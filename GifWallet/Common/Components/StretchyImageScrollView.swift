//
//  StretchyImageScrollView.swift
//  GifWallet
//
//  Created by Jordi Serra i Font on 3/3/18.
//  Copyright © 2018 Pierluigi Cifani. All rights reserved.
//

import UIKit
import FLAnimatedImage
import SDWebImage

class StretchyImageScrollView: UIView {
    
    struct VM {
        let imageURL: URL
        let imageWidth: CGFloat
        let imageHeight: CGFloat
    }
    
    //MARK: - UI Elements
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    let headerImageView: UIImageView = {
        let imageView = FLAnimatedImageView()
//        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let textBacking: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let contentView: UIView
    
    @available(iOS 11.0, *)
    var contentInsetAdjustmentBehavior: UIScrollViewContentInsetAdjustmentBehavior {
        get {
            return scrollView.contentInsetAdjustmentBehavior
        }
        set {
            scrollView.contentInsetAdjustmentBehavior = newValue
        }
    }
    
    //MARK: - View lifecycle
    init(contentView: UIView) {
        self.contentView = contentView
        super.init(frame: .zero)
        setup()
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private API
    private func setup() {
        
    }
    
    private func layout() {
        
        addSubview(scrollView)
        scrollView.pinToSuperview()
        
        scrollView.addSubview(imageContainer)
        scrollView.addSubview(textBacking)
        scrollView.addSubview(contentStackView)
        scrollView.addSubview(headerImageView)
        
        
        NSLayoutConstraint.activate([
            imageContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
//            imageContainer.heightAnchor
//                .constraint(equalTo: imageContainer.widthAnchor, multiplier: 0.55),
            
            headerImageView.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor),
            
            headerImageView.topAnchor
                .constraint(equalTo: topAnchor)
                .settingPriority(to: .defaultHigh),
            headerImageView.heightAnchor
                .constraint(greaterThanOrEqualTo: imageContainer.heightAnchor)
                .settingPriority(to: .required),
            headerImageView.bottomAnchor
                .constraint(equalTo: imageContainer.bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: imageContainer.bottomAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            textBacking.topAnchor.constraint(equalTo: contentStackView.topAnchor),
            textBacking.leadingAnchor.constraint(equalTo: leadingAnchor),
            textBacking.trailingAnchor.constraint(equalTo: trailingAnchor),
            textBacking.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
        
        contentStackView.addArrangedSubview(contentView)
    }
    
    override var backgroundColor: UIColor? {
        didSet {
            textBacking.backgroundColor = backgroundColor
        }
    }
    
    func configureFor(imageURL: URL, imageWidth: CGFloat, imageHeight: CGFloat) {
        headerImageView.sd_setImage(with: imageURL)
        let aspectRatio = imageWidth / imageHeight
        DispatchQueue.main.async {
            self.headerImageView.heightAnchor.constraint(equalToConstant: self.frame.width / aspectRatio).isActive = true
        }
    }
}
