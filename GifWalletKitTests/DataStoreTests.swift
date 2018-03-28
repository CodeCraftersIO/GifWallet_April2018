//
//  Created by Pierluigi Cifani on 28/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import XCTest
@testable import GifWalletKit

class DataStoreTests: XCTestCase {

    var dataStore: DataStore!

    override func setUp() {
        super.setUp()
        dataStore = DataStore()
    }

    func testInit() throws {
        try dataStore.loadAndMigrateIfNeeded().blockingAwait()
        XCTAssert(dataStore.storeIsReady)
    }

}

