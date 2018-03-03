//
//  Data+Wallet.swift
//  GifWallet
//
//  Created by Jordi Serra i Font on 3/3/18.
//  Copyright © 2018 Pierluigi Cifani. All rights reserved.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        return dateFormatter.string(from: self)
    }
}
