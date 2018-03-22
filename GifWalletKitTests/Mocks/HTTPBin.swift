//
//  HTTPBin.swift
//  GifWalletKitTests
//
//  Created by Pierluigi Cifani on 22/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

@testable import GifWalletKit

/// Full-suite tests are courtesy of our good friends of HTTPBin

class HTTPBinAPIClient: APIClient {

    func fetchIPAddress(handler: @escaping(HTTPBin.Responses.IP?, Swift.Error?) -> Void) {
        self.performRequestAndParseResponse(forEndpoint: HTTPBin.API.ip) { (response: HTTPBin.Responses.IP?, error: Swift.Error?) in
            handler(response, error)
        }
    }
}

enum HTTPBin {
    enum Hosts: Environment {
        case production
        case development

        var baseURL: URL {
            switch self {
            case .production:
                return URL(string: "https://httpbin.org")!
            case .development:
                return URL(string: "https://dev.httpbin.org")!
            }
        }
    }

    enum API: Endpoint {
        case ip
        case orderPizza

        var path: String {
            switch self {
            case .orderPizza:
                return "/forms/post"
            case .ip:
                return "/ip"
            }
        }

        var method: HTTPMethod {
            switch self {
            case .orderPizza:
                return .POST
            default:
                return .GET
            }
        }
    }
}

//MARK: Responses

extension HTTPBin {
    enum Responses {
        struct IP: Decodable {
            let origin: String
        }
    }
}
