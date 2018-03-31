//
//  Created by Pierluigi Cifani on 30/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import UIKit

class FormTableViewCell<InputView: ViewModelConfigurable & UIView>: UITableViewCell, ViewModelReusable {

    struct VM {
        let inputVM : InputView.VM
        let showsWarning: Bool
    }

    let formInputView: InputView

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    private let warningIcon: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "warning")!
        imageView.contentMode = .scaleAspectFit
        imageView.image = image.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .red
        let widthConstraint = imageView.widthAnchor.constraint(equalToConstant: image.size.width)
        widthConstraint.priority = .defaultLow
        widthConstraint.isActive = true
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        return imageView
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.formInputView = InputView()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        layout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureFor(vm: VM) {
        warningIcon.isHidden = !vm.showsWarning
        self.formInputView.configureFor(vm: vm.inputVM)
    }

    private func layout() {
        contentView.addAutolayoutView(stackView)
        stackView.pinToSuperview()
        stackView.layoutMargins = Constants.Margins
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.addArrangedSubview(formInputView)
        stackView.addArrangedSubview(warningIcon)
    }
}

private enum Constants {
    static let Margins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
}
