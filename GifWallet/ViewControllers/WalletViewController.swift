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
    
    struct VM {
        var walletList: [GifCell.VM] = []
    }

    private enum Constants {
        static let cellHeight: CGFloat = 200
    }

    var collectionView: UICollectionView!

    var dataSource: CollectionViewStatefulDataSource<GifCell>!

    var interactor = WalletListInteractor()
    
    var viewModel: VM!

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
        collectionView.delegate = self
//        collectionViewLayout.itemSize = CGSize(width: self.view.frame.width, height: Constants.cellHeight)
    }

    private func fetchData() {
        dataSource.updateState(.loading)
        interactor.fetchWallet { [weak self] (walletList) in
            guard let `self` = self else { return }
            self.dataSource.updateState(.loaded(data: walletList))
            self.viewModel = VM(walletList: walletList)
        }
    }
    
    private func navigateToGifDetail(withIdx idx: Int) {
        
        guard (0...viewModel.walletList.count) ~= idx else { return }
        
        interactor.retrieveGifDetails(forGifId: viewModel.walletList[idx].id) { [weak self] (detailVM) in
            guard let `self` = self else { return }
            let vc = GifDetailViewController()
            vc.configureFor(viewModel: detailVM)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension WalletViewController: ListStatePresenter {
    func errorConfiguration(forError error: Error) -> ErrorListConfiguration {
        return .default(ActionableListConfiguration(title: NSAttributedString(string: "Error in gif thingies")))
    }
}

extension WalletViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: Constants.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let gifCell = cell as? GifCell else { return }
        gifCell.delegate = self
    }
}

extension WalletViewController: GifCellTapDelegate {
    func didTapCell(cell: GifCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        
        navigateToGifDetail(withIdx: indexPath.item)
    }
}


protocol GifCellTapDelegate: class {
    func didTapCell(cell: GifCell)
}


final class GifCell: UICollectionViewCell, ViewModelReusable {

    private enum Constants {
        static let margin: CGFloat = 3
        static let spacing: CGFloat = 8
    }

    struct VM {
        let id: String
        let title: String
        let url: URL
    }

    //MARK: - UI Elements
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()

    let imageView: UIImageView = {
        let imageView = FLAnimatedImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.setContentHuggingPriority(.required, for: .vertical)
        return imageView
    }()
    
    //MARK: - Properties
    weak var delegate: GifCellTapDelegate?
    
    var gestureRecognizer: UITapGestureRecognizer!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cellTapped(_:)))
        contentView.addGestureRecognizer(gestureRecognizer)
    }
    
    private func layout() {
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
    
    @objc func cellTapped(_ sender: AnyObject) {
        delegate?.didTapCell(cell: self)
    }
}
