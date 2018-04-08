//
//  HTTPBin.swift
//  GifWalletKitTests
//
//  Created by Pierluigi Cifani on 22/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

@testable import GifWalletKit
import Async

/// Full-suite tests are courtesy of our good friends of HTTPBin

class HTTPBinAPIClient: APIClient {

    func fetchIPAddress() -> Future<HTTPBin.Responses.IP> {
        let ipRequest = Request<HTTPBin.Responses.IP>(
            endpoint: HTTPBin.API.ip
        )
        return self.perform(ipRequest)
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
        case endpointWithSpaces

        var path: String {
            switch self {
            case .orderPizza:
                return "/forms/post"
            case .ip:
                return "/ip"
            case .endpointWithSpaces:
                return "/bad endpoint"
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

        var parameters: [String : Any]? {
            switch self {
            case .endpointWithSpaces:
                return ["bodyParameter": "body with spaces should be fine"]
            default:
                return nil
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
