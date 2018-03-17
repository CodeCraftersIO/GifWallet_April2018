//
//  UIImageView+Wallet.swift
//  GifWallet
//
//  Created by Jordi Serra i Font on 17/3/18.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import SDWebImage

public typealias ImageCompletionBlock = (UIImage?, Error?) -> Void

extension UIImageView {
    
    private static var webDownloadsEnabled = true
    
    static public func disableWebDownloads() {
        webDownloadsEnabled = false
    }
    
    static public func enableWebDownloads() {
        webDownloadsEnabled = false
    }
    
    public func setImageFromURLString(_ url: String) {
        if let url = URL(string: url) {
            setImageWithURL(url)
        }
    }
    
    public func cancelImageLoadFromURL() {
        sd_cancelCurrentImageLoad()
    }
    
    @nonobjc
    public func setImageWithURL(_ url: URL, completed completedBlock: ImageCompletionBlock? = nil) {
        guard UIImageView.webDownloadsEnabled else {
            backgroundColor = UIColor.lightGray
            return
        }
        setImageWithURL(url) { (image, error) in
            completedBlock?(image, error)
        }
    }
}
