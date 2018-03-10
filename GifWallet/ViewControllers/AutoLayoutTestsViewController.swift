//
//  Created by Pierluigi Cifani on 10/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import UIKit

class AutoLayoutTestsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let redView = RedView(frame: .zero)
        view.addSubview(redView)

        // Specify origin
        redView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        redView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
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

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
