//
//  Created by Pierluigi Cifani on 10/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import UIKit
import SDWebImage
import TagListView

class GIFDetailsViewController: UIViewController {

    let gifID: String

    private let presenter = Presenter()

    private var activityView: UIActivityIndicatorView!

    private let imageView: UIImageView = {
        let imageView = FLAnimatedImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let titleLabel = UILabel.autolayoutLabelWith(textStyle: .title1)

    private let subtitleLabel = UILabel.autolayoutLabelWith(textStyle: .body)

    private let tagView: TagListView = {
        let tagView = TagListView()
        tagView.textFont = UIFont.preferredFont(forTextStyle: .body)
        tagView.tagBackgroundColor = UIColor.GifWallet.brand
        tagView.alignment = .left
        tagView.cornerRadius = 5
        return tagView
    }()

    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()

    init(gifID: String) {
        self.gifID = gifID
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        fetchGIFDetails()
    }

    private func setupView() {
        // Add UIScrollView & Container-View
        self.view.addAutolayoutView(scrollView)
        scrollView.pinToSuperviewSafeLayoutEdges()
        scrollView.addAutolayoutView(containerStackView)
        containerStackView.pinToSuperview()

        // Add UIImageView
        containerStackView.addArrangedSubview(self.imageView)

        // Now the details' StackView
        let detailsStackView = UIStackView(arrangedSubviews: [self.titleLabel, self.subtitleLabel, self.tagView])
        detailsStackView.axis = .vertical
        detailsStackView.distribution = .fill
        detailsStackView.alignment = .fill
        detailsStackView.spacing = 10
        detailsStackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        detailsStackView.isLayoutMarginsRelativeArrangement = true
        containerStackView.addArrangedSubview(detailsStackView)

        // Layout the view
        NSLayoutConstraint.activate([
            containerStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            ])

        // Add UIActivityIndicatorView
        activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityView.hidesWhenStopped = true
        self.view.addAutolayoutView(activityView)
        activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    private func fetchGIFDetails() {
        activityView.startAnimating()
        self.presenter.fetchMockGif(gifID: self.gifID) { [weak self] (vm) in
            guard let `self` = self else { return }
            guard let vm = vm else {
                self.navigationController?.popViewController(animated: true)
                return
            }
            self.activityView.stopAnimating()
            self.configureFor(vm: vm)
        }
    }
}

extension GIFDetailsViewController {
    struct VM {
        let gifID: String
        let title: String
        let url: URL
        let subtitle: String
        let tags: Set<String>
    }
}

extension GIFDetailsViewController: ViewModelConfigurable {
    func configureFor(vm: VM) {
        self.titleLabel.text = vm.title
        self.subtitleLabel.text = vm.subtitle
        self.imageView.sd_setImage(with: vm.url, completed: nil)
        self.tagView.addTags(Array(vm.tags))
    }
}
