//
//  Created by Pierluigi Cifani on 07/03/2018.
//  Copyright © 2018 Pierluigi Cifani. All rights reserved.
//

import UIKit

class CollectionViewStatefulDataSource<Cell: ViewModelConfigurable & UICollectionViewCell>: NSObject, UICollectionViewDataSource {

    init(state: ListState<Cell.VM>,
         collectionView: UICollectionView) {
        self.state = state
        self.collectionView = collectionView
        super.init()
        collectionView.dataSource = self
        collectionView.register(Cell.self, forCellWithReuseIdentifier: ReuseID)
    }

    public weak var collectionView: UICollectionView!
    var state: ListState<Cell.VM> {
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseID, for: indexPath) as! Cell
        switch state {
        case .loaded(let data):
            let model = data[indexPath.item]
            cell.configureFor(vm: model)
        default:
            break
        }
        return cell
    }
}

private let ReuseID = "reuseID"
