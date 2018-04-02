//
//  Created by Jordi Serra on 22/3/18.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import UIKit
import SDWebImage

class GIFCollectionViewCell: UICollectionViewCell, ViewModelReusable {

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

    func configureFor(vm: GIFCollectionViewCell.VM) {
        titleLabel.text = vm.title
        imageView.setImageWithURL(vm.url)
        accessibilityValue = vm.title
    }
}

extension GIFCollectionViewCell {
    struct VM {
        let id: String
        let title: String
        let url: URL
    }
}
