//
//  Created by Pierluigi Cifani on 30/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import UIKit

class GIFCreateViewController: UIViewController {

    private let tableView = UITableView(frame: .zero, style: .grouped)

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(self.navigationController != nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(dismissViewController))
        setup()
    }

    @objc func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }

    //MARK: Private

    private func setup() {
        setupTableView()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.pinToSuperviewSafeLayoutEdges()
    }
}
