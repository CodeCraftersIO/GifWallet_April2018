//
//  Created by Pierluigi Cifani on 02/03/2018.
//  Copyright © 2018 Pierluigi Cifani. All rights reserved.
//

import UIKit
import SDWebImage

class GIFWalletViewController: UIViewController {

    private enum Constants {
        static let cellHeight: CGFloat = 200
    }

    var collectionView: UICollectionView!
    var collectionViewLayout: UICollectionViewFlowLayout!
    var dataSource: CollectionViewStatefulDataSource<GIFCollectionViewCell>!
    let interactor: GIFWalletInteractorType
    
    init(interactor: GIFWalletInteractorType) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "GIFWalletView"
        view.backgroundColor = .white
        assert(self.navigationController != nil)
        title = "Your GIFs"
        setup()
        fetchData()
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        coordinator.newCollection = newCollection
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let _ = collectionViewLayout else { return }
        let newCollection = coordinator.newCollection ?? self.traitCollection
        coordinator.animate(alongsideTransition: { (_) in
            self.configureCollectionViewLayout(
                forHorizontalSizeClass: newCollection.horizontalSizeClass,
                targetSize: size
            )
        }, completion: nil)
    }

    private func setup() {
        setupCollectionView()
        dataSource = CollectionViewStatefulDataSource<GIFCollectionViewCell>(
            collectionView: collectionView
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewGif))
    }

    @objc func addNewGif() {
        let createVC = interactor.addNewGIFViewController(observer: self)
        self.present(createVC, animated: true, completion: nil)
    }

    private func setupCollectionView() {
        collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        view.addSubview(collectionView)
        collectionView.pinToSuperviewSafeLayoutEdges()
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        configureCollectionViewLayout(
            forHorizontalSizeClass: self.traitCollection.horizontalSizeClass,
            targetSize: self.view.frame.size
        )
    }

    private func configureCollectionViewLayout(
        forHorizontalSizeClass horizontalSizeClass: UIUserInterfaceSizeClass,
        targetSize: CGSize) {
        let numberOfColumns: Int
        switch horizontalSizeClass {
        case .regular:
            numberOfColumns = (targetSize.width > targetSize.height) ? 3 : 2
        default:
            numberOfColumns = 1
        }
        collectionViewLayout.itemSize = CGSize(
            width: self.view.frame.width / CGFloat(numberOfColumns),
            height: Constants.cellHeight
        )
    }

    private func fetchData() {
        dataSource.state = .loading
        interactor.fetchData { (results, error) in
            guard error == nil else {
                self.dataSource.state = .failure(error: error!)
                return
            }
            self.dataSource.state = .loaded(data: results!)
        }
    }
}

extension GIFWalletViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard case .loaded(let data) = self.dataSource.state else {
            return
        }
        let gifVM = data[indexPath.item]
        self.show(interactor.detailsViewController(gifID: gifVM.id), sender: nil)
    }
}

extension GIFWalletViewController: GIFCreateObserver {
    func didCreateGIF() {
        self.dismiss(animated: true) {
            self.fetchData()
        }
    }
}
