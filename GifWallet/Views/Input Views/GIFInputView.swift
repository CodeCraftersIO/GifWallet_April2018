//
//  Created by Jordi Serra on 29/3/18.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import UIKit
import FLAnimatedImage

protocol GIFInputViewDelegate: class {
    func didTapGIFInputView(_ inputView: GIFInputView)
}

final class GIFInputView: UIView, ViewModelReusable {

    private enum Constants {
        static let maxImageHeight: CGFloat = 200
    }

    struct VM {
        let id: String?
        let url: URL?
    }

    private let gifImageView: UIImageView = {
        let imageView = FLAnimatedImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.isUserInteractionEnabled = true
        imageView.accessibilityIdentifier = "GIFImageToAdd"
        return imageView
    }()

    private var imageHeightConstraint: NSLayoutConstraint!

    weak var delegate: GIFInputViewDelegate?
    
    init() {
        super.init(frame: .zero)
        layout()
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        gifImageView.isUserInteractionEnabled = true
        let tapReco = UITapGestureRecognizer(target: self, action: #selector(onTapGIF))
        gifImageView.addGestureRecognizer(tapReco)
    }

    private func layout() {
        addAutolayoutView(gifImageView)
        gifImageView.pinToSuperview()
        imageHeightConstraint = gifImageView.heightAnchor.constraint(equalToConstant: Constants.maxImageHeight)
        imageHeightConstraint.priority = .required
        imageHeightConstraint.isActive = true
        let imageAspectRatioConstraint = gifImageView.heightAnchor.constraint(equalTo: gifImageView.widthAnchor, multiplier: 1)
        imageAspectRatioConstraint.priority = .defaultLow
        imageAspectRatioConstraint.isActive = true
    }

    func configureFor(vm: GIFInputView.VM) {
        guard let url = vm.url else { return }
        gifImageView.setImageWithURL(url)
    }

    @objc func onTapGIF() {
        self.delegate?.didTapGIFInputView(self)
    }
}
