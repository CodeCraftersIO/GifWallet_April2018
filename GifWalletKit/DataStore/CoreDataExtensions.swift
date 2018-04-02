//
//  Created by Pierluigi Cifani on 29/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import CoreData

extension NSPredicate {
    convenience init(property: String, value: String) {
        self.init(format: "\(property) == %@", value)
    }
}

