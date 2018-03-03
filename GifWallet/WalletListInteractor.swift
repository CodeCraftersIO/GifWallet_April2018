//
//  WalletListInteractor.swift
//  GifWallet
//
//  Created by Pierluigi Cifani on 02/03/2018.
//  Copyright © 2018 Pierluigi Cifani. All rights reserved.
//

import Foundation
import GifWalletKit

final class WalletListInteractor {

    func fetchWallet(completion: @escaping ([GifCell.VM]) -> ()) {
        APIClient.shared.fetchTrends() { trendsResponse in
            completion([GifCell.VM].init(fromResponse: trendsResponse))
        }
    }
    
    func retrieveGifDetails(forGifId id: String, completion: @escaping (GifDetailViewController.VM) -> ()) {
        
        APIClient.shared.retrieveGIF(withId: id) { (gifResponse) in
            completion(GifDetailViewController.VM(fromResponse: gifResponse))
        }
    }
}

extension Array where Element == GifCell.VM {
    init(fromResponse response: TrendsResponse) {
        let elements = response.data.map(GifCell.VM.init)
        self.init(elements)
    }
}

extension GifCell.VM {
    init(fromResponse response: GIFResponse) {
        self.id = response.id
        self.title = response.title
        self.url = response.images.downsized.url
    }
}

extension GifDetailViewController.VM {
    init(fromResponse response: GIFResponse) {
        self.imageURL = response.images.original.url
        self.imageWidth = CGFloat(response.images.original.width)
        self.imageHeight = CGFloat(response.images.original.height)
        self.metadata = GifMetadataView.VM(id: response.id, title: response.title, description: response.importDateTime.toString())
    }
}
