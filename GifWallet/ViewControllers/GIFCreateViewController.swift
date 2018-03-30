//
//  Created by Pierluigi Cifani on 30/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import UIKit
import GifWalletKit

class GIFCreateViewController: UIViewController, UITableViewDataSource {

    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let saveButton = SaveButton()
    private let formValidator = GIFCreateFormValidator()

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
        tableView.keyboardDismissMode = .onDrag
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.registerReusableCell(FormTableViewCell<GIFInputView>.self)
        tableView.registerReusableCell(FormTableViewCell<TextInputView>.self)
        tableView.registerReusableCell(FormTableViewCell<TagsInputView>.self)
        tableView.dataSource = self
    }

    //MARK: UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return formValidator.requiredSections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let section = formValidator.requiredSections[indexPath.section]
        let tableViewCell: UITableViewCell = {
            switch section {
            case .gifURL:
                let cell: FormTableViewCell<GIFInputView> = tableView.dequeueReusableCell(indexPath: indexPath)
                cell.configureFor(vm: FormTableViewCell<GIFInputView>.VM(inputVM: GIFInputView.VM(id: "hello", url: URL(string: "https://media0.giphy.com/media/8752sSo2HbPqE7MN03/giphy.gif")!), showsWarning: true))
                cell.formInputView.delegate = self
                return cell
            case .title:
                let cell: FormTableViewCell<TextInputView> = tableView.dequeueReusableCell(indexPath: indexPath)
                cell.configureFor(vm: FormTableViewCell<TextInputView>.VM(inputVM: TextInputView.VM(text: nil), showsWarning: true))
                cell.formInputView.placeholder = "Enter the Title"
                cell.formInputView.delegate = self
                return cell
            case .subtitle:
                let cell: FormTableViewCell<TextInputView> = tableView.dequeueReusableCell(indexPath: indexPath)
                cell.configureFor(vm: FormTableViewCell<TextInputView>.VM(inputVM: TextInputView.VM(text: nil), showsWarning: true))
                cell.formInputView.placeholder = "Enter the Subtitle"
                cell.formInputView.delegate = self
                return cell
            case .tags:
                let cell: FormTableViewCell<TagsInputView> = tableView.dequeueReusableCell(indexPath: indexPath)
                cell.configureFor(vm: FormTableViewCell<TagsInputView>.VM(inputVM: TagsInputView.VM(tags: ["Studio", "iOS", "Funny"]), showsWarning: true))
                cell.formInputView.delegate = self
                return cell
            }
        }()
        return tableViewCell
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

extension GIFCreateViewController: GIFInputViewDelegate, TextInputViewDelegate, TagsInputViewDelegate {
    
    func didModifyText(text: String, textInputView: TextInputView) {

    }

    func didAddTag(newTag: String, tagsInputView: TagsInputView) {

    }

    func didTapGIFInputView(_ inputView: GIFInputView) {

    }
}
