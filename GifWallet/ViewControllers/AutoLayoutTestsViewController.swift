//
//  Created by Pierluigi Cifani on 10/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import UIKit

class AutoLayoutTestsViewController: UIViewController {

    let redView = RedView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(redView)

        // Specify origin
        redView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        redView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true

        print("Horiziontal: \(self.traitCollection.horizontalSizeClass.printableDescription)")
        print("Vertical: \(self.traitCollection.verticalSizeClass.printableDescription)")
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        print("Horiziontal: \(self.traitCollection.horizontalSizeClass.printableDescription)")
        print("Vertical: \(self.traitCollection.verticalSizeClass.printableDescription)")
    }
}

class RedView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .red

        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Code Crafters"
        self.addSubview(label)

        self.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            label.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor)
            ])
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        print("Horiziontal: \(self.traitCollection.horizontalSizeClass.printableDescription)")
        print("Vertical: \(self.traitCollection.verticalSizeClass.printableDescription)")
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

