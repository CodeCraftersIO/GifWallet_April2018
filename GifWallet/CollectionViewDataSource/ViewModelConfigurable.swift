//
//  Created by Pierluigi Cifani on 07/03/2018.
//  Copyright © 2018 Pierluigi Cifani. All rights reserved.
//

import Foundation

protocol ViewModelConfigurable {
    associatedtype VM
    func configureFor(vm: VM)
}
