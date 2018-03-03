//
//  NSLayoutConstraint+Wallet.swift
//  GifWallet
//
//  Created by Jordi Serra i Font on 3/3/18.
//  Copyright © 2018 Pierluigi Cifani. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    func settingPriority(to priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
