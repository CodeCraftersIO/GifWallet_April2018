//
//  Created by Jordi Serra i Font on 18/3/18.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import UIKit

extension UITextField {

    static func autolayoutTextFieldWith(textStyle style: UIFont.TextStyle, placeholderText: String) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.preferredFont(forTextStyle: style)
        textField.setContentHuggingPriority(.required, for: .vertical)
        textField.placeholder = placeholderText
        return textField
    }
}
