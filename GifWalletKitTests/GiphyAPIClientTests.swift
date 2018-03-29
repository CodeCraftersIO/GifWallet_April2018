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

    func testGetTrending() throws {
        let trendingFuture = apiClient.fetchTrending()
        let _ = try self.waitAndExtractValue(future: trendingFuture)
    }

    func testSearchTerm() throws {
        let searchFuture = apiClient.searchGif(term: "hello")
        let _ = try self.waitAndExtractValue(future: searchFuture)
    }
}
