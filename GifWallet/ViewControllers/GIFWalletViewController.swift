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
    var dataSource: CollectionViewStatefulDataSource<GifCell>!
    var presenter = Presenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Your GIFs"
        setup()
        fetchData()
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        guard let _ = collectionViewLayout else { return }
        coordinator.animate(alongsideTransition: { (_) in
            self.configureCollectionViewLayout(forHorizontalSizeClass: newCollection.horizontalSizeClass)
        }, completion: nil)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }

    private func setup() {
        setupCollectionView()
        dataSource = CollectionViewStatefulDataSource<GifCell>(
            collectionView: collectionView
        )
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
        configureCollectionViewLayout(forHorizontalSizeClass: self.traitCollection.horizontalSizeClass)
    }

    private func configureCollectionViewLayout(forHorizontalSizeClass horizontalSizeClass: UIUserInterfaceSizeClass) {
        let numberOfColumns: Int
        switch horizontalSizeClass {
        case .regular:
            numberOfColumns = 2
        default:
            numberOfColumns = 1
        }
        collectionViewLayout.itemSize = CGSize(
            width: self.view.frame.width / CGFloat(numberOfColumns),
            height: Constants.cellHeight
        )
    }

    private func fetchData() {
        presenter.fetchMockData { (listState) in
            self.dataSource.state = listState
        }
    }
}

extension GIFWalletViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard case .loaded(let data) = self.dataSource.state else {
            return
        }

        let gifVM = data[indexPath.item]
        let vc = GIFDetailsViewController(gifID: gifVM.id)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension GIFWalletViewController {
    struct VM {
        let id: String
        let title: String
        let url: URL
    }
}

extension GIFWalletViewController {

    class GifCell: UICollectionViewCell, ViewModelReusable {

        private enum Constants {
            static let margin: CGFloat = 3
            static let spacing: CGFloat = 8
        }

        //MARK: - UI Elements
        let titleLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 2
            label.textAlignment = .center
            return label
        }()

        let imageView: UIImageView = {
            let imageView = FLAnimatedImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            return imageView
        }()

        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setup() {

            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.distribution = .fill
            stackView.alignment = .fill
            stackView.spacing = Constants.spacing
            stackView.layoutMargins = UIEdgeInsets(top: Constants.margin, left: Constants.margin, bottom: Constants.margin, right: Constants.margin)
            stackView.isLayoutMarginsRelativeArrangement = true

            contentView.addSubview(stackView)
            stackView.pinToSuperview()

            stackView.addArrangedSubview(imageView)
            stackView.addArrangedSubview(titleLabel)
        }

        func configureFor(vm: GIFWalletViewController.VM) {
            titleLabel.text = vm.title
            imageView.sd_setImage(with: vm.url, completed: nil)
        }
    }
}
