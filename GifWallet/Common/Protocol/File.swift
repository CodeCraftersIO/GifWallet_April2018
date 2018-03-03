//
//  File.swift
//  GifWallet
//
//  Created by Jordi Serra i Font on 3/3/18.
//  Copyright © 2018 Pierluigi Cifani. All rights reserved.
//

import Foundation

protocol ViewModelConfigurable {
    associatedtype VM
    func configureFor(viewModel: VM)
}
