//
//  Created by Pierluigi Cifani on 07/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import UIKit

class GIFWalletPresenter {
    func fetchMockData(handler: @escaping (ListState<GIFWalletViewController.VM>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            handler(.loaded(data: MockLoader.mockCellVM()))
        }
    }
}
