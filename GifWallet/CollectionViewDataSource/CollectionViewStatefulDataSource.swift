//
//  Created by Pierluigi Cifani on 07/03/2018.
//  Copyright © 2018 Pierluigi Cifani. All rights reserved.
//

import UIKit

class CollectionViewStatefulDataSource<Cell: ViewModelReusable & UICollectionViewCell>: NSObject, UICollectionViewDataSource {

    init(state: ListState<Cell.VM>,
         collectionView: UICollectionView) {
        self.state = state
        self.collectionView = collectionView
        super.init()
        collectionView.dataSource = self
        collectionView.registerReusableCell(Cell.self)
    }

    fileprivate var emptyView: UIView?
    public weak var collectionView: UICollectionView!
    var state: ListState<Cell.VM> {
        didSet {
            collectionView.reloadData()
        }
    }

    //MARK: UICollectionViewDataSource
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        defer {
            addEmptyViewForCurrentState()
        }

        switch state {
        case .loaded(let data):
            return data.count
        default:
            return 0
        }
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: Cell = collectionView.dequeueReusableCell(indexPath: indexPath)
        switch state {
        case .loaded(let data):
            let model = data[indexPath.item]
            cell.configureFor(vm: model)
        default:
            break
        }
        return cell
    }

    //MARK: Private
    fileprivate func addEmptyViewForCurrentState() {
        self.emptyView?.removeFromSuperview()

        let newEmptyView: UIView? = {
            switch state {
            case .loaded(let data):
                if data.count == 0 {
                    let label = UILabel()
                    label.text = "No results, sorry"
                    return label
                } else {
                    return nil
                }
            case .loading:
                let activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
                activity.startAnimating()
                return activity
            case .failure(let error):
                let label = UILabel()
                label.text = "Error: \(error.localizedDescription)"
                return label
            }
        }()

        guard let emptyView = newEmptyView, let collectionView = self.collectionView else { return }

        collectionView.addSubview(emptyView)
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        emptyView.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor, constant: -20).isActive = true
        self.emptyView = newEmptyView
    }
}

