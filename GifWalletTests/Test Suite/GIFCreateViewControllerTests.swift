//
//  Created by Pierluigi Cifani on 30/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import XCTest
@testable import GifWallet

class GIFCreateViewControllerTests: SnapshotTest {
    func testBasicLayout() {
        let interactor = MockInteractor(observer: MockInteractor.Observer())
        let vc = GIFCreateViewController.Factory.viewController(interactor: interactor)
        presentViewController(vc)
        waitABitAndVerify(viewController: vc)
    }
}

private class MockInteractor: GIFCreateInteractorType {

    class Observer: GIFCreateObserver {
        func didCreateGIF() {

        }
    }

    required init(observer: GIFCreateObserver) {

    }

    func createGIF(giphyID: String, title: String, subtitle: String, url: URL, tags: Set<String>) {

    }
}
