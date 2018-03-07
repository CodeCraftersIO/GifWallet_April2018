//
//  GifWallet+Mocke.swift
//  GifWallet
//
//  Created by Pierluigi Cifani on 02/03/2018.
//  Copyright © 2018 Pierluigi Cifani. All rights reserved.
//

import Foundation

enum MockLoader {
    static func mockCellVM() -> [GifListVM] {
        return [
            GifListVM(id: "NK1", title: "Nike", url: URL(string: "https://media0.giphy.com/media/8752sSo2HbPqE7MN03/giphy.gif")!),
            GifListVM(id: "NK2", title: "Pepsi", url: URL(string: "https://media1.giphy.com/media/9SJa1HlQCDgH63pOkE/giphy-downsized.gif")!),
            GifListVM(id: "NK3", title: "National Basketball Association", url: URL(string: "https://media2.giphy.com/media/5zkWsc184ZNkQqt5TH/giphy.gif")!),
            GifListVM(id: "NK4", title: "Relax Now", url: URL(string: "https://media3.giphy.com/media/g0HnUvpLRvRNF00KQ3/giphy.gif")!),
            GifListVM(id: "NK5", title: "weellsensuyanto", url: URL(string: "https://media3.giphy.com/media/2fHui9nDO3DFIcEAgE/giphy.gif")!),
            GifListVM(id: "NK6", title: "Will&Grace", url: URL(string: "https://media3.giphy.com/media/KWeLWLazd9eN959QRV/giphy.gif")!),
            GifListVM(id: "NK7", title: "Strong", url: URL(string: "https://media.giphy.com/media/MVfD3AzTWl7Ss7xJsL/giphy.gif")!),
        ]
    }
}
