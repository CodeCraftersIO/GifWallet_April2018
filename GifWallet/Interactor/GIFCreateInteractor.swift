//
//  Created by Pierluigi Cifani on 31/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import GifWalletKit

protocol GIFCreateObserver: class {
    func didCreateGIF()
}

protocol GIFCreateInteractorType {
    init(observer: GIFCreateObserver)
    func createGIF(giphyID: String, title: String, subtitle: String, url: URL, tags: Set<String>)
}

extension GIFCreateViewController {

    class Interactor: GIFCreateInteractorType {

        weak var observer: GIFCreateObserver?
        var dataStore: DataStore!

        required init(observer: GIFCreateObserver) {
            self.observer = observer
        }

        func createGIF(giphyID: String, title: String, subtitle: String, url: URL, tags: Set<String>) {
            dataStore
                .createGIF(giphyID: giphyID, title: title, subtitle: subtitle, url: url, tags: tags)
                .do {
                    self.observer?.didCreateGIF()
                }
                .catch { (error) in
                    print("Error saving GIF \(error)")
            }
        }
    }

    class MockInteractor: GIFCreateInteractorType {

        required init(observer: GIFCreateObserver) {

        }

        func createGIF(giphyID: String, title: String, subtitle: String, url: URL, tags: Set<String>) {

        }
    }
}
