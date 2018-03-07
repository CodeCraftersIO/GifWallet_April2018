//
//  WalletListInteractor.swift
//  GifWallet
//
//  Created by Pierluigi Cifani on 02/03/2018.
//  Copyright © 2018 Pierluigi Cifani. All rights reserved.
//

import Foundation

final class WalletListInteractor {

    func fetchWallet(completion: @escaping ([GifListVM]) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            completion(MockLoader.mockCellVM())
        }
    }
}
