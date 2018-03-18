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
    var dataSource: CollectionViewStatefulDataSource<GifCell>!
    let interactor: GIFWalletInteractorType
    
    init(interactor: GIFWalletInteractorType = MockDataInteractor()) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        assert(self.navigationController != nil)
        title = "Your GIFs"
        setup()
        fetchData()
    }

    private func setup() {
        setupCollectionView()
        dataSource = CollectionViewStatefulDataSource<GifCell>(
            collectionView: collectionView
        )
    }

    private func setupCollectionView() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: self.view.frame.width, height: Constants.cellHeight)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        view.addSubview(collectionView)
        collectionView.pinToSuperviewSafeLayoutEdges()
        collectionView.backgroundColor = .white
        collectionView.delegate = self
    }

    private func fetchData() {
        interactor.fetchData { (listState) in
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
            imageView.setImageWithURL(vm.url)
        }
    }
}
