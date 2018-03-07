//
//  Created by Pierluigi Cifani on 07/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import UIKit

protocol ViewModelConfigurable: class {
    associatedtype VM
    func configureFor(vm: VM)
}

protocol ViewModelReusable: ViewModelConfigurable {
    static var reuseType: ReuseType { get }
    static var reuseIdentifier: String { get }
}

//MARK:- Extensions

extension ViewModelReusable {
    public static var reuseIdentifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!

    }
    public static var reuseType: ReuseType {
        return .classReference(self)
    }
}

enum ReuseType {
    case nib(UINib)
    case classReference(AnyClass)
}

