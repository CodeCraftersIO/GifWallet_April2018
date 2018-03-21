//
//  Created by Pierluigi Cifani on 21/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import Foundation

public protocol Endpoint {

    /// The path for the request
    var path: String { get }

    /// The HTTPMethod for the request
    var method: HTTPMethod { get }

    /// Optional parameters for the request
    var parameters: [String : Any]? { get }

    /// The HTTP headers to be sent
    var httpHeaderFields: [String : String]? { get }
}

public enum HTTPMethod: String {
    case GET, POST, PUT, DELETE, OPTIONS, HEAD, PATCH, TRACE, CONNECT
}

extension Endpoint {
    public var method: HTTPMethod {
        return .GET
    }

    public var parameters: [String : Any]? {
        return nil
    }

    public var httpHeaderFields: [String : String]? {
        return nil
    }
}
