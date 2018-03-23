//
//  Created by Pierluigi Cifani on 21/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import Foundation

public protocol Environment {
    var baseURL: URL { get }
    var shouldAllowInsecureConnections: Bool { get }
}

public extension Environment {
    var shouldAllowInsecureConnections: Bool {
        return false
    }
}
