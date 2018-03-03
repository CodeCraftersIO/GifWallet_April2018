//
//  GIFParsingTests.swift
//  GifWalletKitTests
//
//  Created by Jordi Serra i Font on 3/3/18.
//  Copyright © 2018 Pierluigi Cifani. All rights reserved.
//

import XCTest
@testable import GifWalletKit

class GIFParsingTests: XCTestCase {
    
    func testParseTrendsJSON() {
        
        guard let fileURL = Bundle.main.url(forResource: "trends", withExtension: "json"),
            let data = try? Data(contentsOf: fileURL)
        else {
            fatalError("Could not find trends.json file")
        }
        
        guard let response = try? JSONDecoder().decode(TrendsResponse.self, from: data) else {
            XCTFail("Could not parse trends.json into TrendsResponse Type")
            return
        }
        XCTAssert(response.data.count == 25)
    }
    
}
