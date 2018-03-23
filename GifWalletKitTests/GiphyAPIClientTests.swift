//
//  Created by Pierluigi Cifani on 23/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import XCTest
@testable import GifWalletKit

class GiphyAPIClientTests: XCTestCase {

    var apiClient: GiphyAPIClient!

    override func setUp() {
        super.setUp()
        apiClient = GiphyAPIClient()
    }

    func testGetTrending() {
        let exp = expectation(description: "Fetch Completes")

        apiClient
            .fetchTrending()
            .do { (response) in
                exp.fulfill()
            }.catch { (error) in
                exp.fulfill()
                XCTFail()
        }

        wait(for: [exp], timeout: 3)

    }

    func testSearchTerm() {
        let exp = expectation(description: "Fetch Completes")
        apiClient
            .searchGif(term: "hello")
            .do { (response) in
                exp.fulfill()
            }.catch { (error) in
                exp.fulfill()
                XCTFail()
        }
        wait(for: [exp], timeout: 3)
    }
}
