//
//  Created by Pierluigi Cifani on 10/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import UIKit

class GIFDetailsViewController: UIViewController {

    let presenter = Presenter()
    let gifID: String
    var activityView: UIActivityIndicatorView!

    init(gifID: String) {
        self.gifID = gifID
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        fetchGIFDetails()
    }

    private func setupView() {
        //Add UIActivityIndicatorView
        activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityView.hidesWhenStopped = true
        self.view.addSubview(activityView)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    private func fetchGIFDetails() {
        activityView.startAnimating()
        self.presenter.fetchMockGif(gifID: self.gifID) { [weak self] (vm) in
            guard let `self` = self else { return }
            guard let vm = vm else {
                self.navigationController?.popViewController(animated: true)
                return
            }
            self.activityView.stopAnimating()
        }
    }
}

extension GIFDetailsViewController {
    struct VM {
        let gifID: String
        let title: String
        let url: URL
        let subtitle: String
        let tags: Set<String>
    }
}
