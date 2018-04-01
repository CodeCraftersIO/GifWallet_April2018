//
//  Created by Pierluigi Cifani on 02/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import Foundation
import Async

public protocol APIClientNetworkFetcher {
    func fetchData(with urlRequest: URLRequest) -> Future<Data>
}

open class APIClient {

    let environment: Environment
    let signature: Signature?
    let jsonDecoder = JSONDecoder()
    var delegateQueue = DispatchQueue.main
    let workerQueue = DispatchQueue.global(qos: .userInitiated)
    let networkFetcher: APIClientNetworkFetcher

    public init(environment: Environment, signature: Signature? = nil, networkFetcher: APIClientNetworkFetcher = URLSession(configuration: .default)) {
        self.environment = environment
        self.signature = signature
        self.networkFetcher = networkFetcher
    }

    public func perform<T: Decodable>(_ request: Request<T>) -> Future<T> {

        let urlRequest: Future<URLRequest> = self.createURLRequest(endpoint: request.endpoint)
        let downloadData = urlRequest.flatMap(to: Data.self) { (urlRequest) in
            return self.networkFetcher.fetchData(with: urlRequest)
        }
        let parseData = downloadData.flatMap(to: T.self) { (data) in
            return self.parseResponse(data: data)
        }
        return parseData
    }

    private func parseResponse<T: Decodable>(data: Data) -> Future<T> {
        let promise = Promise<T>()
        workerQueue.async {
            do {
                let request: T = try self.parseResponse(data: data)
                promise.complete(request)
            } catch let error {
                promise.fail(error)
            }
        }
        return promise.future
    }

    private func parseResponse<T: Decodable>(data: Data) throws -> T {
        do {
            return try self.jsonDecoder.decode(T.self, from: data)
        }
        catch {
            throw Error.malformedJSONResponse
        }
    }

    private func createURLRequest(endpoint: Endpoint) -> Future<URLRequest> {
        let promise = Promise<URLRequest>()
        workerQueue.async {
            do {
                let request: URLRequest = try self.createURLRequest(endpoint: endpoint)
                promise.complete(request)
            } catch let error {
                promise.fail(error)
            }
        }
        return promise.future
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
        case unknownError
    }

    public struct Signature {
        let name: String
        let value: String
    }
}

extension URLSession: APIClientNetworkFetcher {
    public func fetchData(with urlRequest: URLRequest) -> Future<Data> {
        let promise = Promise<Data>()
        let task = self.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                promise.fail(error!)
                return
            }

            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200,
                let data = data else {
                    promise.fail(APIClient.Error.malformedResponse)
                    return
            }

            promise.complete(data)
        }
        task.resume()
        return promise.future
    }
}
