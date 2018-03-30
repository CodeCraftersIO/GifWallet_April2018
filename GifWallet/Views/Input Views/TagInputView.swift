//
//  Created by Jordi Serra on 29/3/18.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import UIKit
import TagListView

protocol TagsInputViewDelegate: class {
    func didAddTag(newTag: String, tagsInputView: TagsInputView)
}

final class TagsInputView: UIView, ViewModelConfigurable {

    private enum Constants {
        static let TextInputWidth: CGFloat = 200
    }

    struct VM {
        let tags: [String]
    }

    let tagView: TagListView = {
        let tagView = TagListView()
        tagView.textFont = UIFont.preferredFont(forTextStyle: .body)
        tagView.tagBackgroundColor = UIColor.GifWallet.brand
        tagView.alignment = .left
        tagView.cornerRadius = 5
        tagView.setContentHuggingPriority(.required, for: .vertical)
        tagView.setContentHuggingPriority(.required, for: .horizontal)
        return tagView
    }()

    let textField = UITextField.autolayoutTextFieldWith(textStyle: .body, placeholderText: "Intro Tag Here")
    var minHeightAnchor: NSLayoutConstraint!

    weak var delegate: TagsInputViewDelegate?

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
        addAutolayoutView(tagView)
        minHeightAnchor = self.heightAnchor.constraint(equalToConstant: 40)

        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.trailingAnchor.constraint(equalTo: tagView.leadingAnchor),
            textField.widthAnchor.constraint(equalToConstant: Constants.TextInputWidth),
            tagView.topAnchor.constraint(equalTo: topAnchor),
            tagView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tagView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }

    func configureFor(vm: VM) {
        tagView.addTags(vm.tags)
        minHeightAnchor.isActive = (vm.tags.count == 0)
    }
}

extension TagsInputView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        defer { textField.resignFirstResponder() }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.delegate?.didAddTag(newTag: textField.text ?? "", tagsInputView: self)
    }
}
