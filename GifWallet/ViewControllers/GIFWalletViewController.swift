//
//  Created by Pierluigi Cifani on 02/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import UIKit

class GIFWalletViewController: UIViewController {

    var collectionView: UICollectionView!

    private enum Constants {
        static let cellHeight: CGFloat = 200
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Your Gifs"
        setupCollectionView()
    }

    private func setupCollectionView() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: self.view.frame.width, height: Constants.cellHeight)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        view.addSubview(collectionView)
        collectionView.pinToSuperviewSafeLayoutEdges()
        collectionView.backgroundColor = .white
    }
}

extension GIFWalletViewController {
    struct VM {
        let id: String
        let title: String
        let url: URL
    }
}

import SDWebImage

extension GIFWalletViewController {

    class GifCell: UICollectionViewCell {

        private enum Constants {
            static let margin: CGFloat = 3
            static let spacing: CGFloat = 8
        }

        //MARK: - UI Elements
        let titleLabel: UILabel = {
            let label = UILabel()
            label.setContentHuggingPriority(.required, for: .vertical)
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
    }
}
