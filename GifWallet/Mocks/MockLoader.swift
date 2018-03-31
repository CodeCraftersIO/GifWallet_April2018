//
//  Created by Pierluigi Cifani on 08/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import Foundation

enum MockLoader {
    static func mockCellVM() -> [GIFCollectionViewCell.VM] {
        return mockedDetailGifs.map({ (gifDetails) in
            return GIFCollectionViewCell.VM(id: gifDetails.gifID, title: gifDetails.title, url: gifDetails.url)
        })
    }

    static func mockDetailGif(gifID: String) -> GIFDetailsViewController.VM? {
        return mockedDetailGifs.first(where: { return $0.gifID == gifID })
    }

    private static var mockedDetailGifs: [GIFDetailsViewController.VM] {
        return [
            GIFDetailsViewController.VM(gifID: "NK1", title: "Nike", url: URL(string: "https://media0.giphy.com/media/8752sSo2HbPqE7MN03/giphy.gif")!, subtitle: "This is a very long subtitle, only done like this to make sure we're not getting enough attention and we should really worry about this.", tags: ["funny", "LOL", "Nike", "OMG"]),
            GIFDetailsViewController.VM(gifID: "NK2", title: "Pepsi", url: URL(string: "https://media1.giphy.com/media/9SJa1HlQCDgH63pOkE/giphy-downsized.gif")!, subtitle: "This is a very long subtitle, only done like this to make sure we're not getting enough attention and we should really worry about this.", tags: ["funny", "LOL", "Pepsi", "OMG"]),
            GIFDetailsViewController.VM(gifID: "NK3", title: "National Basketball Association", url: URL(string: "https://media2.giphy.com/media/5zkWsc184ZNkQqt5TH/giphy.gif")!, subtitle: "This is a very long subtitle, only done like this to make sure we're not getting enough attention and we should really worry about this.", tags: ["funny", "LOL", "NBA", "OMG"]),
            GIFDetailsViewController.VM(gifID: "NK4", title: "Relax Now", url: URL(string: "https://media3.giphy.com/media/g0HnUvpLRvRNF00KQ3/giphy.gif")!, subtitle: "This is a very long subtitle, only done like this to make sure we're not getting enough attention and we should really worry about this.", tags: ["funny", "LOL", "RELAX", "OMG"]),
            GIFDetailsViewController.VM(gifID: "NK5", title: "weellsensuyanto", url: URL(string: "https://media3.giphy.com/media/2fHui9nDO3DFIcEAgE/giphy.gif")!, subtitle: "This is a very long subtitle, only done like this to make sure we're not getting enough attention and we should really worry about this.", tags: ["funny", "LOL", "BUG", "OMG"]),
            GIFDetailsViewController.VM(gifID: "NK6", title: "Will&Grace", url: URL(string: "https://media3.giphy.com/media/KWeLWLazd9eN959QRV/giphy.gif")!, subtitle: "This is a very long subtitle, only done like this to make sure we're not getting enough attention and we should really worry about this.", tags: ["funny", "LOL", "Will&Grace", "OMG"]),
            GIFDetailsViewController.VM(gifID: "NK7", title: "Strong", url: URL(string: "https://media.giphy.com/media/MVfD3AzTWl7Ss7xJsL/giphy.gif")!, subtitle: "This is a very long subtitle, only done like this to make sure we're not getting enough attention and we should really worry about this.", tags: ["funny", "LOL", "Strong", "OMG"]),
    ]
    }
}
