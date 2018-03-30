//
//  Created by Pierluigi Cifani on 30/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import UIKit

class GIFCreateViewController: UIViewController, UITableViewDataSource {

    private let tableView = UITableView(frame: .zero, style: .plain)
    private let saveButton = SaveButton()

    private init() {
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
        layout()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.contentInset = UIEdgeInsets(
            top: tableView.contentInset.top + 0,
            left: tableView.contentInset.left + 0,
            bottom: tableView.contentInset.bottom + saveButton.frame.size.height,
            right: tableView.contentInset.right + 0
        )
    }

    @objc func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func onSave() {

    }


    //MARK: Private

    private func setup() {
        setupTableView()
        saveButton.addTarget(self, action: #selector(onSave), for: .touchDown)
    }

    private func layout() {
        view.addSubview(tableView)
        tableView.pinToSuperviewSafeLayoutEdges()

        saveButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveButton)
        NSLayoutConstraint.activate([
            saveButton.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            saveButton.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            saveButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            ])
    }

    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ReuseID")
        tableView.dataSource = self
    }

    //MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReuseID")
        cell?.textLabel?.text = "HelloWorld"
        return cell!
    }
}

extension GIFCreateViewController {
    enum Factory {
        static func viewController() -> UIViewController {
            let createVC = GIFCreateViewController()
            let navController = UINavigationController(rootViewController: createVC)
            navController.modalPresentationStyle = .formSheet
            return navController
        }
    }
}
