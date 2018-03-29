//
//  Created by Pierluigi Cifani on 29/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import XCTest
import Async

extension XCTestCase {
    func waitAndExtractValue<T>(future: Future<T>) throws -> T {
        var value: T!
        var error: Swift.Error!
        let exp = self.expectation(description: "Extract from Future")
        future
            .do {
                value = $0
                exp.fulfill()
            }.catch {
                error = $0
                exp.fulfill()
        }
        self.wait(for: [exp], timeout: 1)
        if let error = error {
            throw error
        }
        return value
    }
}
