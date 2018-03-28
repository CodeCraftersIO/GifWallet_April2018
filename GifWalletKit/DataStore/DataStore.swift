//
//  Created by Pierluigi Cifani on 28/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import CoreData
import Async

public class DataStore {

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

    //MARK: GIF Creation
    func createGIF(giphyID: String, title: String, subtitle: String, url: URL, tags: Set<String>) -> Future<()> {
        let promise = Promise<()>()
        guard self.storeIsReady else {
            promise.fail(DataStore.Error.dataStoreNotInitialized)
            return promise.future
        }

        self.persistentStore.performBackgroundTask { (moc) in
            let managedGIF = ManagedGIF(entity: ManagedGIF.entity(), insertInto: moc)
            managedGIF.title = title
            managedGIF.subtitle = subtitle
            managedGIF.remoteURL = url.absoluteString
            managedGIF.giphyID = giphyID
            managedGIF.creationDate = Date()

            do {
                try moc.save()
                promise.complete()
            } catch let error {
                promise.fail(error)
            }
        }
        return promise.future
    }

    func fetchGIF(id: String) throws -> ManagedGIF? {
        guard self.storeIsReady else {
            throw DataStore.Error.dataStoreNotInitialized
        }

        let fetchRequest: NSFetchRequest<ManagedGIF> = ManagedGIF.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "giphyID == %@", id)
        let managedGIFs = try self.persistentStore.viewContext.fetch(fetchRequest)
        return managedGIFs.first
    }
}


extension DataStore {

    public enum Kind {
        case sqlite
        case memory
    }

    public enum Error: Swift.Error {
        case dataStoreNotInitialized
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
