//
//  GifDetailViewController.swift
//  GifWallet
//
//  Created by Jordi Serra i Font on 3/3/18.
//  Copyright © 2018 Pierluigi Cifani. All rights reserved.
//

import UIKit

final class GifDetailViewController: UIViewController {
    
    struct VM {
        let imageURL: URL
        let imageWidth: CGFloat
        let imageHeight: CGFloat
        let metadata: GifMetadataView.VM
    }
    
    private enum Constants {
        
    }
    
    lazy var stretchyScrollView: StretchyImageScrollView = {
        let stretchyScrollView = StretchyImageScrollView(contentView: detailView)
        return stretchyScrollView
    }()
    
    let detailView: GifMetadataView = {
        let view = GifMetadataView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func setup() {
        
    }
    
    private func layout() {
        view.addSubview(stretchyScrollView)
        stretchyScrollView.pinToSuperview()
    }
    
    func configureFor(viewModel: VM) {
        stretchyScrollView.configureFor(imageURL: viewModel.imageURL, imageWidth: viewModel.imageWidth, imageHeight: viewModel.imageHeight)
        detailView.configureFor(viewModel: viewModel.metadata)
    }
}

final class GifMetadataView: UIView {
    
    struct VM {
        let id: String
        let title: String
        let description: String
    }
    
    private enum Constants {
        static let stackViewSpacing: CGFloat = 8
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        
    }
    
    private func layout() {
        let rootStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.distribution = .fill
            stackView.alignment = .fill
            stackView.spacing = Constants.stackViewSpacing
            return stackView
        }()
        
        rootStackView.addArrangedSubview(titleLabel)
        rootStackView.addArrangedSubview(descriptionLabel)
        
        addSubview(rootStackView)
        rootStackView.pinToSuperviewSafeLayoutEdges()
    }
    
    public func configureFor(viewModel: VM) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
    }
}
