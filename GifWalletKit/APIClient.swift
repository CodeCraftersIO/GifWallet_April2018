//
//  Created by Pierluigi Cifani on 02/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//
import Foundation

open class APIClient {

    let environment: Environment
    let urlSession: URLSession
    let signature: Signature?
    let jsonDecoder = JSONDecoder()
    var delegateQueue = DispatchQueue.main

    public init(environment: Environment, signature: Signature? = nil) {
        self.environment = environment
        self.signature = signature
        self.urlSession = URLSession(configuration: .default)
    }

    public func perform<T: Decodable>(_ request: Request<T>, handler: @escaping (T?, Swift.Error?) -> Void) {
        self.performRequest(forEndpoint: request.endpoint) { (data, error) in
            guard error == nil else {
                self.delegateQueue.async { handler(nil, error!) }
                return
            }
            guard let data = data else {
                self.delegateQueue.async { handler(nil, Error.malformedResponse) }
                return
            }

            let response: T
            do {
                response = try self.parseResponse(data: data)
            } catch let error {
                self.delegateQueue.async { handler(nil, error) }
                return
            }

            handler(response, nil)
        }
    }

    public func performRequest(forEndpoint endpoint: Endpoint, handler: @escaping (Data?, Swift.Error?) -> Void) {
        let urlRequest: URLRequest
        do {
            urlRequest = try self.createURLRequest(endpoint: endpoint)
        } catch let error {
            delegateQueue.async { handler(nil, error) }
            return
        }

        let task = self.urlSession.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                self.delegateQueue.async { handler(nil, error) }
                return
            }

            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200,
                let data = data else {
                self.delegateQueue.async { handler(nil, Error.malformedResponse) }
                return
            }

            self.delegateQueue.async { handler(data, nil) }
        }
        task.resume()
    }


    private func parseResponse<T: Decodable>(data: Data) throws -> T {
        do {
            return try self.jsonDecoder.decode(T.self, from: data)
        }
        catch {
            throw Error.malformedJSONResponse
        }
    }

    private func createURLRequest(endpoint: Endpoint) throws -> URLRequest {
        guard let URL = URL(string: endpoint.path, relativeTo: self.environment.baseURL) else {
            throw Error.malformedURL
        }

        var urlRequest = URLRequest(url: URL)
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.allHTTPHeaderFields = endpoint.httpHeaderFields
        urlRequest.setValue("GifWallet - iOS", forHTTPHeaderField: "User-Agent")
        if let signature = self.signature {
            urlRequest.setValue(
                signature.value,
                forHTTPHeaderField: signature.name
            )
        }
        if let parameters = endpoint.parameters {
            do {
                let requestData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                urlRequest.httpBody = requestData
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                throw Error.malformedParameters
            }
        }
        return urlRequest
    }

    public enum Error: Swift.Error {
        case serverError
        case malformedURL
        case malformedParameters
        case malformedResponse
        case malformedJSONResponse
    }

    public struct Signature {
        let name: String
        let value: String
    }
}
