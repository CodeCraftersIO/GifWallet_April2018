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
        redView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    }
}

class RedView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .red
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 50, height: 50)
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
