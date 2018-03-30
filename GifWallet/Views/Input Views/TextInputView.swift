//
//  Created by Jordi Serra on 29/3/18.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import UIKit

protocol TextInputViewDelegate: class {
    func didModifyText(text: String, textInputView: TextInputView)
}

final class TextInputView: UIView, ViewModelConfigurable {

    struct VM {
        let text: String?
    }

    private let textField = UITextField.autolayoutTextFieldWith(textStyle: .body, placeholderText: "")
    
    weak var delegate: TextInputViewDelegate?

    var placeholder: String? {
        set {
            textField.placeholder = newValue
        }
        get {
            return textField.placeholder
        }
    }
    
    init() {
        super.init(frame: .zero)
        setup()
        layout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        textField.delegate = self
    }

    private func layout() {
        addAutolayoutView(textField)
        textField.pinToSuperview()
    }

    func configureFor(vm: TextInputView.VM) {
        textField.text = vm.text
    }
}

extension TextInputView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.delegate?.didModifyText(text: textField.text ?? "", textInputView: self)
    }
}
