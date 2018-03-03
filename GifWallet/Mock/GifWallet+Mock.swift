//
//  GifWallet+Mocke.swift
//  GifWallet
//
//  Created by Pierluigi Cifani on 02/03/2018.
//  Copyright © 2018 Pierluigi Cifani. All rights reserved.
//

import Foundation

extension GifCell.VM {
    static let mock = GifCell.VM.init(id: "CR9", title: "A mock title", url: URL(string: "https://media1.giphy.com/media/uxuSBlXyRpKrS/200w_d.gif")!)
}

extension Array where Element == GifCell.VM {
    static let trending: [Element] = [
        GifCell.VM.init(id: "NK1", title: "Nike", url: URL(string: "https://media0.giphy.com/media/8752sSo2HbPqE7MN03/giphy.gif")!),
        GifCell.VM.init(id: "PS1", title: "Pepsi", url: URL(string: "https://media1.giphy.com/media/9SJa1HlQCDgH63pOkE/giphy-downsized.gif")!),
        GifCell.VM.init(id: "NBA1", title: "National Basketball Association", url: URL(string: "https://media2.giphy.com/media/5zkWsc184ZNkQqt5TH/giphy.gif")!),
        GifCell.VM.init(id: "OSC", title: "Academy Awards", url: URL(string: "https://media0.giphy.com/media/8752sSo2HbPqE7MN03/giphy.gif")!),
        GifCell.VM.init(id: "WEL1", title: "weellsensuyanto", url: URL(string: "https://media3.giphy.com/media/2fHui9nDO3DFIcEAgE/giphy.gif")!),
        GifCell.VM.init(id: "WEL1", title: "weellsensuyanto", url: URL(string: "https://media3.giphy.com/media/2fHui9nDO3DFIcEAgE/giphy.gif")!),
        GifCell.VM.init(id: "WEL1", title: "weellsensuyanto", url: URL(string: "https://media3.giphy.com/media/2fHui9nDO3DFIcEAgE/giphy.gif")!),
    ]
}

extension GifDetailViewController.VM {
    static let mock = GifDetailViewController.VM.init(imageURL: URL(string: "https://media0.giphy.com/media/8752sSo2HbPqE7MN03/giphy.gif")!, imageWidth: 480, imageHeight: 270, metadata: GifMetadataView.VM(id: "CR9", title: "Cristiano", description: "He is a football player"))
}
