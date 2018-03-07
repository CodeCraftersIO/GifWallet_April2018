//
//  Created by Pierluigi Cifani on 07/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import UIKit

extension UICollectionView {
    func registerReusableCell<T: UICollectionViewCell>(_: T.Type) where T: ViewModelReusable {
        switch T.reuseType {
        case .classReference(let className):
            self.register(className, forCellWithReuseIdentifier: T.reuseIdentifier)
        case .nib(let nib):
            self.register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
        }
    }

    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T where T: ViewModelReusable {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Did you register this cell?")
        }
        return cell
    }
}
