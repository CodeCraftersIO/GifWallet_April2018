//
//  Created by Jordi Serra i Font on 18/3/18.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import GifWalletKit
import Async

protocol GIFSearchInteractorType {
    func performRequest(_ request: GIFSearchViewController.Request, handler: @escaping ([GIFCollectionViewCell.VM]?, Swift.Error?) -> Void)
}

extension GIFSearchViewController {

    enum Request {
        case trending
        case search(term: String)
    }

    class Interactor: GIFSearchInteractorType {

        let apiClient = GiphyAPIClient()

        func performRequest(_ request: GIFSearchViewController.Request, handler: @escaping ([GIFCollectionViewCell.VM]?, Swift.Error?) -> Void) {
            let future: Future<Giphy.Responses.Page> = {
                switch request {
                case .trending:
                    return self.apiClient.fetchTrending()
                case .search(let term):
                    return self.apiClient.searchGif(term: term)
                }
            }()
            let vmFuture = future.map(to: [GIFCollectionViewCell.VM].self) { (page) in
                return page.data.compactMap({ (gif)  in
                    return GIFCollectionViewCell.VM(id: gif.id, title: gif.title, url: gif.url)
                })
            }

            vmFuture
                .do {
                    handler($0, nil)
                }
                .catch {
                    handler(nil, $0)
            }
        }
    }

    class MockDataInteractor: GIFSearchInteractorType {

        var delaySeconds: Int = 1

        func performRequest(_ request: GIFSearchViewController.Request, handler: @escaping ([GIFCollectionViewCell.VM]?, Swift.Error?) -> Void) {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delaySeconds)) {
                handler(MockLoader.mockCellVM(), nil)
            }
        }
    }
}
