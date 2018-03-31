//
//  Created by Pierluigi Cifani on 31/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import Foundation

func fetchMockedData(jsonNamed: String) -> Data {
    guard let path = Bundle(for: MockJSONLoading.self).path(forResource: jsonNamed, ofType: "json") else {
        fatalError()
    }
    let url = URL.init(fileURLWithPath: path)
    guard let data = try? Data(contentsOf: url) else {
        fatalError()
    }
    return data
}

private class MockJSONLoading: NSObject { }
