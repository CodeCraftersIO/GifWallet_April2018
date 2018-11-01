//
//  Created by Pierluigi Cifani on 10/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import UIKit
import SDWebImage
import TagListView

class GIFDetailsViewController: UIViewController {

    let gifID: String

    private var vm: VM?
    private let interactor: GIFDetailInteractorType
    private var activityView: UIActivityIndicatorView!

    private let imageView: UIImageView = {
        let imageView = FLAnimatedImageView()
        imageView.contentMode = .scaleAspectFit
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
        tagView.setContentHuggingPriority(.required, for: .vertical)
        tagView.setContentHuggingPriority(.required, for: .horizontal)
        return tagView
    }()

    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()

    private let detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()

    private var landscapeConstraints: [NSLayoutConstraint]!
    private var portraitConstraints: [NSLayoutConstraint]!
    private var imageAspectRatioConstraint: NSLayoutConstraint!

    init(gifID: String, interactor: GIFDetailInteractorType) {
        self.gifID = gifID
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        fetchGIFDetails()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (context) in
            self.configureStackViews(forContainerViewSize: size)
        }, completion: nil)
    }

    @objc func shareGIF() {
        guard
            let vm = self.vm,
            let path = SDImageCache.shared().defaultCachePath(forKey: vm.url.absoluteString) else { return }

        let url = URL(fileURLWithPath: path)

        guard let data = try? Data(contentsOf: url) else { return }

        let controller = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        
        // Specify the anchor point for the popover.
        controller.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(controller, animated: true, completion: nil)
    }

    private func setupView() {
        // Add UIScrollView & Container-View
        self.view.addAutolayoutView(scrollView)
        scrollView.pinToSuperviewSafeLayoutEdges()
        scrollView.addAutolayoutView(containerStackView)
        containerStackView.pinToSuperview()

        // Add UIImageView
        containerStackView.addArrangedSubview(self.imageView)
        self.imageAspectRatioConstraint = self.imageView.widthAnchor.constraint(equalTo: self.imageView.heightAnchor, multiplier: 1)

        // Now the details' StackView
        let topSpacingView = UIView.verticalSpacingView()
        let bottomSpacingView = UIView.verticalSpacingView()
        detailsStackView.addArrangedSubview(topSpacingView)
        detailsStackView.addArrangedSubview(self.titleLabel)
        detailsStackView.addArrangedSubview(self.subtitleLabel)
        detailsStackView.addArrangedSubview(self.tagView)
        detailsStackView.addArrangedSubview(bottomSpacingView)
        containerStackView.addArrangedSubview(detailsStackView)

        NSLayoutConstraint.activate([
            topSpacingView.heightAnchor.constraint(equalTo: bottomSpacingView.heightAnchor),
            containerStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            self.imageAspectRatioConstraint
            ])

        portraitConstraints = [
            topSpacingView.heightAnchor.constraint(lessThanOrEqualToConstant: 0),
        ]

        landscapeConstraints = [
            imageView.widthAnchor.constraint(lessThanOrEqualTo: detailsStackView.widthAnchor, multiplier: 2, constant: 0),
            containerStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ]

        self.configureStackViews(forContainerViewSize: self.view.frame.size)

        // Add UIActivityIndicatorView
        activityView = UIActivityIndicatorView(style: .gray)
        activityView.hidesWhenStopped = true
        self.view.addAutolayoutView(activityView)
        activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    private func configureStackViews(forContainerViewSize size: CGSize) {
        if size.width > size.height {
            self.containerStackView.axis = .horizontal
            landscapeConstraints.forEach { $0.isActive = true }
            portraitConstraints.forEach { $0.isActive = false }
        } else {
            self.containerStackView.axis = .vertical
            landscapeConstraints.forEach { $0.isActive = false }
            portraitConstraints.forEach { $0.isActive = true }
        }
    }

    private func fetchGIFDetails() {
        activityView.startAnimating()
        self.interactor.fetchGifDetails(gifID: self.gifID) { [weak self] (vm) in
            guard let `self` = self else { return }
            guard let vm = vm else {
                self.closeViewController(sender: self)
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
        let subtitle: String
        let url: URL
        let tags: Set<String>
    }
}

extension GIFDetailsViewController: ViewModelConfigurable {
    func configureFor(vm: VM) {
        self.vm = vm
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareGIF))

        self.titleLabel.text = vm.title
        self.subtitleLabel.text = vm.subtitle
        self.imageView.setImageWithURL(vm.url) { (image, error) in
            guard let image = image else { return }
            if let imageAspectRatioConstraint = self.imageAspectRatioConstraint {
                self.imageView.removeConstraint(imageAspectRatioConstraint)
            }
            let aspectRatio = image.size.width/image.size.height
            self.imageAspectRatioConstraint = self.imageView.widthAnchor.constraint(equalTo: self.imageView.heightAnchor, multiplier: aspectRatio)
            self.imageAspectRatioConstraint.priority = .defaultHigh
            self.imageAspectRatioConstraint.isActive = true
        }
        self.tagView.removeAllTags()
        self.tagView.addTags(Array(vm.tags))
    }
}
