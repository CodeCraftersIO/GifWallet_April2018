//
//  Created by Pierluigi Cifani on 02/03/2018.
//  Copyright © 2018 Pierluigi Cifani. All rights reserved.
//

import UIKit
import SDWebImage
import BSWInterfaceKit

struct GifViewModel {
    let title: String
    let gif: URL
}

class WalletViewController: UIViewController {

    private enum Constants {
        static let cellHeight: CGFloat = 200
    }

    var collectionView: UICollectionView!

    var dataSource: CollectionViewStatefulDataSource<GifCell>!

    var interactor = WalletListInteractor()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Your Gifs"
        setup()
        fetchData()
    }

    private func setup() {
        setupCollectionView()

        dataSource = CollectionViewStatefulDataSource(collectionView: collectionView, listPresenter: self)
    }

    private func setupCollectionView() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        view.addSubview(collectionView)
        collectionView.pinToSuperviewSafeLayoutEdges()
        collectionView.backgroundColor = .white
        collectionViewLayout.itemSize = CGSize(width: self.view.frame.width, height: Constants.cellHeight)
    }

    private func fetchData() {
        dataSource.updateState(.loading)
        interactor.fetchWallet { [weak self] (walletList) in
            guard let `self` = self else { return }
            self.dataSource.updateState(.loaded(data: walletList))
        }
    }
}

extension WalletViewController: ListStatePresenter {
    func errorConfiguration(forError error: Error) -> ErrorListConfiguration {
        return .default(ActionableListConfiguration(title: NSAttributedString(string: "Error in gif thingies")))
    }
}


final class GifCell: UICollectionViewCell, ViewModelReusable {

    private enum Constants {
        static let margin: CGFloat = 3
        static let spacing: CGFloat = 8
    }

    struct VM {
        let title: String
        let url: URL
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

    func configureFor(viewModel: GifCell.VM) {
        titleLabel.text = viewModel.title
        imageView.sd_setImage(with: viewModel.url, completed: nil)
    }
}
