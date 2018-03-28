//
//  Created by Pierluigi Cifani on 28/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import CoreData
import Async

public class DataStore {

    public enum Kind {
        case sqlite
        case memory
    }

    private let persistentStore: NSPersistentContainer
    public var storeIsReady: Bool = false

    public init(kind: Kind = .sqlite) {
        guard
            let path = Bundle(for: DataStore.self).path(forResource: "Model", ofType: "momd"),
            let model = NSManagedObjectModel(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError()
        }

        persistentStore = NSPersistentContainer(
            name: "GifModel",
            managedObjectModel: model
        )

        let description = NSPersistentStoreDescription()
        description.type = kind.coreDataRepresentation
        persistentStore.persistentStoreDescriptions = [description]
    }

    public func loadAndMigrateIfNeeded() -> Future<()> {
        let promise = Promise<()>()
        persistentStore.loadPersistentStores { (description, error) in
            if let error = error {
                promise.fail(error)
            } else {
                self.storeIsReady = true
                promise.complete(())
            }
        }
        return promise.future
    }
}

extension DataStore.Kind {
    fileprivate var coreDataRepresentation: String {
        switch self {
        case .memory:
            return NSInMemoryStoreType
        case .sqlite:
            return NSSQLiteStoreType
        }
    }
}
