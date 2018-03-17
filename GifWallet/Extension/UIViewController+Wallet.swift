//
//  Created by Pierluigi Cifani on 17/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import UIKit

extension UIViewController {
    //Based on https://stackoverflow.com/a/28158013/1152289
    @objc func dismissViewController(sender: Any?) {
        guard let presentingVC = targetViewController(forAction: #selector(dismissViewController(sender:)), sender: sender) else { return }
        presentingVC.dismissViewController(sender: sender)
    }
}

extension UINavigationController {
    @objc
    override func dismissViewController(sender: Any?) {
        self.popViewController(animated: true)
    }
}

