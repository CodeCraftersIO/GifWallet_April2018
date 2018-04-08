//
//  Created by Pierluigi Cifani on 23/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import XCTest
@testable import GifWalletKit

class GiphyAPIClientTests: XCTestCase {

    var apiClient: GiphyAPIClient!
    private var networkFetcher: MockGiphyNetworkFetcher!

    override func setUp() {
        super.setUp()
        networkFetcher = MockGiphyNetworkFetcher()
        apiClient = GiphyAPIClient(networkFetcher: networkFetcher)
    }

    func testGetTrending() throws {
        networkFetcher.mockedRequest = .trending
        let trendingFuture = apiClient.fetchTrending()
        let _ = try self.waitAndExtractValue(future: trendingFuture)
    }

    func testSearchTerm() throws {
        networkFetcher.mockedRequest = .search
        let searchFuture = apiClient.searchGif(term: "hello")
        let _ = try self.waitAndExtractValue(future: searchFuture)
    }
}

import Async

private class MockGiphyNetworkFetcher: APIClientNetworkFetcher {
    enum MockedRequest: String {
        case trending
        case search
        var mockedData: Data {
            return fetchMockedData(jsonNamed: self.rawValue)
        }
    }

    var mockedRequest: MockedRequest!

    func fetchData(with urlRequest: URLRequest) -> Future<Data> {
        let promise = Promise<Data>()
        promise.complete(mockedRequest.mockedData)
        return promise.future
    }
}
