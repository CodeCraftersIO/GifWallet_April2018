//
//  Created by Pierluigi Cifani on 07/03/2018.
//  Copyright © 2018 Pierluigi Cifani. All rights reserved.
//

import UIKit

protocol GIFWalletInteractorType {
    func fetchData(handler: @escaping (ListState<GIFCollectionViewCell.VM>) -> Void)
}

extension GIFWalletViewController {
    
    class MockDataInteractor: GIFWalletInteractorType {
        
        var delaySeconds: Int = 1
        
        func fetchData(handler: @escaping (ListState<GIFCollectionViewCell.VM>) -> Void) {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delaySeconds)) {
                handler(.loaded(data: MockLoader.mockCellVM()))
            }
        }
    }
}

