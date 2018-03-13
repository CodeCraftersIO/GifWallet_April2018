//
//  Created by Pierluigi Cifani on 13/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import UIKit
import ObjectiveC

private var xoAssociationKey: UInt8 = 0

extension UIViewControllerTransitionCoordinator {
    var newCollection: UITraitCollection? {
        get {
            return objc_getAssociatedObject(self, &xoAssociationKey) as? UITraitCollection
        }
        set(newValue) {
            objc_setAssociatedObject(self, &xoAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}
