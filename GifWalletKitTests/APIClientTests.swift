//
//  Created by Pierluigi Cifani on 02/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import XCTest
@testable import GifWalletKit


class HTTPBINAPITests: XCTestCase {
    func testIPEndpoint() {
        let getIP = HTTPBin.API.ip
        XCTAssert(getIP.path == "/ip")
        XCTAssert(getIP.method == .GET)
    }

    func testParseIPResponse() throws {
        let json =
"""
{
  "origin": "80.34.92.76"
}
"""
            .data(using: .utf8)!
        let decoder = JSONDecoder()
        let response = try decoder.decode(HTTPBin.Responses.IP.self, from: json)
        XCTAssert(response.origin == "80.34.92.76")
    }
}

class HTTPBinAPIClientTests: XCTestCase {

    var apiClient: HTTPBinAPIClient!

    override func setUp() {
        super.setUp()
        apiClient = HTTPBinAPIClient(environment: HTTPBin.Hosts.production)
    }

    func testGET() {

        let exp = expectation(description: "Fetch Completes")

        apiClient.fetchIPAddress { (response, error) in
            XCTAssert(response != nil)
            exp.fulfill()
        }

        wait(for: [exp], timeout: 3)
    }
}
