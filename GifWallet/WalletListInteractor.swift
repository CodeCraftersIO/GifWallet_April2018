//
//  WalletListInteractor.swift
//  GifWallet
//
//  Created by Pierluigi Cifani on 02/03/2018.
//  Copyright © 2018 Pierluigi Cifani. All rights reserved.
//

import Foundation

final class WalletListInteractor {

    func fetchWallet(completion: @escaping ([GifCell.VM]) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            completion((0...8).map { _ in GifCell.VM.mock })
        }
    }
}
