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

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.numberOfLines = 0
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
    }()

    private let tagView: TagListView = {
        let tagView = TagListView()
        tagView.textFont = UIFont.preferredFont(forTextStyle: .body)
        tagView.tagBackgroundColor = UIColor.GifWallet.brand
        tagView.alignment = .left
        tagView.cornerRadius = 5
        return tagView
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
        // Add UIActivityIndicatorView
        activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityView.hidesWhenStopped = true
        self.view.addAutolayoutView(activityView)
        activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        // Add UIScrollView & Container-View
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        self.view.addAutolayoutView(scrollView)
        scrollView.pinToSuperviewSafeLayoutEdges()
        let containerView = UIView()
        scrollView.addAutolayoutView(containerView)
        containerView.pinToSuperview()

        // Add UIImageView
        containerView.addAutolayoutView(self.imageView)

        // Now the details' StackView
        let detailsStackView = UIStackView(arrangedSubviews: [self.titleLabel, self.subtitleLabel, self.tagView])
        detailsStackView.axis = .vertical
        detailsStackView.distribution = .fill
        detailsStackView.alignment = .fill
        detailsStackView.spacing = 10
        detailsStackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        detailsStackView.isLayoutMarginsRelativeArrangement = true
        containerView.addAutolayoutView(detailsStackView)

        // Layout the view
        let layoutGuide = containerView
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            self.imageView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            self.imageView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            detailsStackView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor),
            detailsStackView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            detailsStackView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            detailsStackView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
            ])
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
