//
//  Created by Pierluigi Cifani on 18/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import XCTest
@testable import GifWallet

class GIFDetailViewControllerTests: SnapshotTest {

    func testGIFWalletViewController() {
        let interactor = GIFDetailsViewController.MockDataInteractor()
        interactor.delaySeconds = 0
        let vc = GIFDetailsViewController(gifID: "NK1", interactor: interactor)
        let navigationController = UINavigationController(rootViewController: vc)
        waitABitAndVerify(viewController: navigationController)
    }
}
