//
//  Created by Jordi Serra i Font on 17/3/18.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import XCTest
import FBSnapshotTestCase

class SnapshotTest: FBSnapshotTestCase {

    var waiter = XCTWaiter()

    override func setUp() {
        super.setUp()

        // Set snapshot device agnostic. It will happen "iPhone" to the snapshot filename
        isDeviceAgnostic = true

        // Disable downloading images from web to avoid flaky tests.
        UIImageView.disableWebDownloads()
    }

    var currentWindow: UIWindow {
        return UIApplication.shared.keyWindow!
    }

    var rootViewController: UIViewController? {
        get {
            return currentWindow.rootViewController
        }

        set(newRootViewController) {
            currentWindow.rootViewController = newRootViewController
            currentWindow.makeKeyAndVisible()
        }
    }

    /// Add the view controller on the window and wait infinitly
    func debugViewController(_ viewController: UIViewController) {
        rootViewController = viewController
        let exp = expectation(description: "No expectation")
        let _ = waiter.wait(for: [exp], timeout: 1000)
        waiter = XCTWaiter()
    }

    func debugView(_ view: UIView) {
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        vc.view.addSubview(view)
        debugViewController(vc)
    }

    /// Presents the VC using a fresh rootVC in the host's main window.
    /// - note: This method blocks the calling thread until the presentation is finished.
    func presentViewController(_ viewController: UIViewController) {
        let exp = expectation(description: "Presentation")
        rootViewController = UIViewController()
        rootViewController!.view.backgroundColor = .white // I just think it looks pretier this way
        rootViewController!.present(viewController, animated: true, completion: {
            exp.fulfill()
        })
        let _ = waiter.wait(for: [exp], timeout: 10)
        waiter = XCTWaiter()
    }

    func waitABitAndVerify(viewController: UIViewController) {
        rootViewController = viewController
        waitABitAndVerify(view: viewController.view)
    }

    func waitABitAndVerify(view: UIView) {

        view.setNeedsLayout()
        view.layoutIfNeeded()

        if let scrollView = view as? UIScrollView, !isDeviceAgnostic {
            scrollView.frame = CGRect(
                x: scrollView.frame.origin.x,
                y: scrollView.frame.origin.y,
                width: scrollView.contentSize.width,
                height: scrollView.contentSize.height
            )
        }

        let exp = expectation(description: "verify view")
        let deadlineTime = DispatchTime.now() + .milliseconds(50)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            self.FBSnapshotVerifyView(view)
            exp.fulfill()
        }
        let _ = waiter.wait(for: [exp], timeout: 1)
        waiter = XCTWaiter()
    }
}

