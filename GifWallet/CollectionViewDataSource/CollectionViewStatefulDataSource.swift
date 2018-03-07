//
//  Created by Pierluigi Cifani on 07/03/2018.
//  Copyright © 2018 Pierluigi Cifani. All rights reserved.
//

import UIKit

class CollectionViewStatefulDataSource: NSObject, UICollectionViewDataSource {

    init(state: ListState<GIFWalletViewController.VM>,
         collectionView: UICollectionView,
         cellType: UICollectionViewCell.Type) {
        self.state = state
        self.cellType = cellType
        self.collectionView = collectionView
        super.init()
        collectionView.dataSource = self
        collectionView.register(cellType, forCellWithReuseIdentifier: "reuseID")
    }

    private static let ReuseID = "reuseID"
    public weak var collectionView: UICollectionView!
    public let cellType: UICollectionViewCell.Type
    var state: ListState<GIFWalletViewController.VM> {
        didSet {
            collectionView.reloadData()
        }
    }

    //MARK: UICollectionViewDataSource
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch state {
        case .loaded(let data):
            return data.count
        default:
            return 0
        }
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewStatefulDataSource.ReuseID, for: indexPath)
        return cell
    }
}
