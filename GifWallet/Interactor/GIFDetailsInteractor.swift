//
//  Created by Pierluigi Cifani on 10/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import Foundation

protocol GIFDetailInteractorType {
    func fetchGifDetails(gifID: String, handler: @escaping (GIFDetailsViewController.VM?) -> Void)
}

extension GIFDetailsViewController {

    class MockDataInteractor: GIFDetailInteractorType {

        var delaySeconds: Int = 1

        func fetchGifDetails(gifID: String, handler: @escaping (GIFDetailsViewController.VM?) -> Void) {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delaySeconds)) {
                handler(MockLoader.mockDetailGif(gifID: gifID))
            }
        }
    }
}

