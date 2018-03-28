//
//  Created by Pierluigi Cifani on 28/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import CoreData
import Async

class DataStore {

    let persistentStore: NSPersistentContainer

    init() {

        guard
            let path = Bundle(for: DataStore.self).path(forResource: "Model", ofType: "momd"),
            let model = NSManagedObjectModel(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError()
        }

        persistentStore = NSPersistentContainer(name: "GifModel", managedObjectModel: model)
        persistentStore.loadPersistentStores { (_, _) in

        }
    }
}

