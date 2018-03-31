//
//  Created by Pierluigi Cifani on 30/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import UIKit

class SaveButton: UIButton {

    private enum Constants {
        static let Padding: CGFloat = 10
    }

    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor.GifWallet.brand
        setTitle("Save", for: .normal)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func safeAreaInsetsDidChange() {
        super.safeAreaInsetsDidChange()
        self.titleEdgeInsets = UIEdgeInsets.init(
            top: self.safeAreaInsets.bottom / 2 ,
            left: 0,
            bottom: 0,
            right: 0
        )
        self.contentEdgeInsets = UIEdgeInsets.init(
            top: self.safeAreaInsets.top + Constants.Padding,
            left: self.safeAreaInsets.left + Constants.Padding,
            bottom: self.safeAreaInsets.bottom + Constants.Padding,
            right: self.safeAreaInsets.right + Constants.Padding
        )
    }
}
