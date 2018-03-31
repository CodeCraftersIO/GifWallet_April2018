//
//  Created by Pierluigi Cifani on 30/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import UIKit

extension UITableView {
    func registerReusableCell<T: UITableViewCell>(_: T.Type) where T: ViewModelReusable {
        switch T.reuseType {
        case .classReference(let className):
            self.register(className, forCellReuseIdentifier: T.reuseIdentifier)
        case .nib(let nib):
            self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
        }
    }

    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: ViewModelReusable {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Did you register this cell?")
        }
        return cell
    }
}
