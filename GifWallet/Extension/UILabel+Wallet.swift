//
//  Created by Pierluigi Cifani on 10/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import UIKit

extension UILabel {

    public static func autolayoutLabelWith(textStyle style: UIFontTextStyle) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: style)
        label.numberOfLines = 0
        return label
    }

}
