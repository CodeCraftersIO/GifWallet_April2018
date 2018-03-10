//
//  Created by Pierluigi Cifani on 10/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import Foundation

extension GIFDetailsViewController {
    class Presenter {
        func fetchMockGif(gifID: String, handler: @escaping (GIFDetailsViewController.VM?) -> Void) {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                handler(MockLoader.mockDetailGif(gifID: gifID))
            }
       }
    }
}
