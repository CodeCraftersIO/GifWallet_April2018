//
//  Created by Jordi Serra i Font on 18/3/18.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import Foundation

protocol GIFSearchInteractorType {
    func trendingGifs(handler: @escaping ([GIFCollectionViewCell.VM]) -> Void)
    func searchGifs(term: String, handler: @escaping ([GIFCollectionViewCell.VM]) -> Void)
}

extension GIFSearchViewController {

    class MockDataInteractor: GIFSearchInteractorType {

        var delaySeconds: Int = 1

        func trendingGifs(handler: @escaping ([GIFCollectionViewCell.VM]) -> Void) {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delaySeconds)) {
                handler(MockLoader.mockCellVM())
            }
        }

        func searchGifs(term: String, handler: @escaping ([GIFCollectionViewCell.VM]) -> Void) {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delaySeconds)) {
                handler(MockLoader.mockCellVM())
            }
        }
    }
}
