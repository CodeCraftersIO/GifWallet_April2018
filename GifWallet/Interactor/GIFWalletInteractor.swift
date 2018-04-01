//
//  Created by Pierluigi Cifani on 07/03/2018.
//  Copyright © 2018 Pierluigi Cifani. All rights reserved.
//

import UIKit
import GifWalletKit

protocol GIFWalletInteractorType {
    func fetchData(handler: @escaping ([GIFCollectionViewCell.VM]?, Swift.Error?) -> Void)
    func addNewGIFViewController(observer: GIFCreateObserver) -> UIViewController
    func detailsViewController(gifID: String) -> UIViewController
}

extension GIFWalletViewController {

    class Interactor: GIFWalletInteractorType {

        let dataStore: DataStore

        init(dataStore: DataStore) {
            self.dataStore = dataStore
        }

        func fetchData(handler: @escaping ([GIFCollectionViewCell.VM]?, Swift.Error?) -> Void) {
            dataStore
                .loadAndMigrateIfNeeded()
                .flatMap(to: [ManagedGIF].self) {
                    return self.dataStore.fetchGIFsSortedByCreationDate()
                }
                .map(to: [GIFCollectionViewCell.VM].self) { (managedGIFs) in
                    let vms: [GIFCollectionViewCell.VM] = managedGIFs.compactMap {
                        guard let giphyID = $0.giphyID,
                            let title = $0.title,
                            let urlString = $0.remoteURL,
                            let url = URL(string: urlString) else {
                                return nil
                        }
                        return GIFCollectionViewCell.VM(id: giphyID, title: title, url: url)
                    }
                    return vms
                }
                .do {
                    handler($0, nil)
                }
                .catch {
                    handler(nil, $0)
            }
        }

        func addNewGIFViewController(observer: GIFCreateObserver) -> UIViewController {
            let interactor = GIFCreateViewController.Interactor.init(observer: observer)
            interactor.dataStore = dataStore
            return GIFCreateViewController.Factory.viewController(interactor: interactor)
        }

        func detailsViewController(gifID: String) -> UIViewController {
            let interactor = GIFDetailsViewController.Interactor(dataStore: self.dataStore)
            return GIFDetailsViewController.init(gifID: gifID, interactor: interactor)
        }
    }

    class MockDataInteractor: GIFWalletInteractorType {
        
        var delaySeconds: Int = 1
        
        func fetchData(handler: @escaping ([GIFCollectionViewCell.VM]?, Swift.Error?) -> Void) {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delaySeconds)) {
                handler(MockLoader.mockCellVM(), nil)
            }
        }

        func addNewGIFViewController(observer: GIFCreateObserver) -> UIViewController {
            let interactor = GIFCreateViewController.MockInteractor(observer: observer)
            return GIFCreateViewController.Factory.viewController(interactor: interactor)
        }

        func detailsViewController(gifID: String) -> UIViewController {
            return GIFDetailsViewController(gifID: gifID, interactor: GIFDetailsViewController.MockDataInteractor())
        }
    }
}

