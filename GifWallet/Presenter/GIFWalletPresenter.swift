//
//  Created by Pierluigi Cifani on 07/03/2018.
//  Copyright © 2018 Pierluigi Cifani. All rights reserved.
//

import UIKit

extension GIFWalletViewController {
    class Presenter {
        func fetchMockData(handler: @escaping (ListState<GIFWalletViewController.VM>) -> Void) {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                handler(.loaded(data: MockLoader.mockCellVM()))
            }
        }
    }
}

