//
//  GifWalletTests.swift
//  GifWalletTests
//
//  Created by Pierluigi Cifani on 02/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import XCTest
@testable import GifWallet

class GIFWalletViewControllerTests: GIFWalletSnapshotTest {
    
    func testGIFWalletViewController() {
        let interactor = GIFWalletViewController.MockDataInteractor()
        interactor.delaySeconds = 0
        let vc = GIFWalletViewController(interactor: interactor)
        let navigationController = UINavigationController(rootViewController: vc)
        waitABitAndVerify(viewController: navigationController)
    }
}
