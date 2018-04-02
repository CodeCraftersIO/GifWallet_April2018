//
//  Created by Pierluigi Cifani on 28/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import XCTest
@testable import GifWalletKit

class DataStoreTests: XCTestCase {

    var dataStore: DataStore!

    override func setUp() {
        super.setUp()
        dataStore = DataStore(kind: .memory, shouldLoadAsync: false)
        try? dataStore.loadAndMigrateIfNeeded().blockingAwait()
        XCTAssert(dataStore.storeIsReady)
    }

    func testCreateAndFetchGIF() throws {
        let managedGIF = try self.createAndFetch(
            giphyID: "007",
            title: "James Bond",
            subtitle: "GoldenEye",
            url: URL(string: "google.com/007")!,
            tags: ["007"]
        )
        XCTAssert(managedGIF.giphyID == "007")
        XCTAssert(managedGIF.title == "James Bond")
        XCTAssert(managedGIF.creationDate != nil)
        XCTAssert(managedGIF.tags.contains("007"))
    }

    func testCreateAFetchGIFTwice() throws {
        let JamesBondID = "007"
        let _ = try self.createAndFetch(
            giphyID: JamesBondID,
            title: "James Bond",
            subtitle: "GoldenEye",
            url: URL(string: "google.com/007")!,
            tags: ["007"]
        )

        let managedGIF = try self.createAndFetch(
            giphyID: JamesBondID,
            title: "James Bond",
            subtitle: "Tomorrow Never Dies",
            url: URL(string: "google.com/007")!,
            tags: ["007"]
        )

        XCTAssert(managedGIF.subtitle == "Tomorrow Never Dies")
    }

    func testFetchGIFsViaTag() throws {
        let sampleTag = "007"
        let _ = try self.createAndFetch(
            giphyID: "007",
            title: "James Bond",
            subtitle: "Tomorrow Never Dies",
            url: URL(string: "google.com/007")!,
            tags: [sampleTag]
        )

        let managedGIFs = try dataStore.fetchGIFs(withTag: sampleTag)
        XCTAssert(managedGIFs.count == 1)
    }

    func testQueryAllGIFsChronologically() throws {
        let JamesBondID = "007"
        let _ = try self.createAndFetch(
            giphyID: JamesBondID,
            title: "James Bond",
            subtitle: "GoldenEye",
            url: URL(string: "google.com/007")!,
            tags: ["007"]
        )

        let SupermanID = "Superman"
        let _ = try self.createAndFetch(
            giphyID: SupermanID,
            title: "Superman",
            subtitle: "Kryptonite",
            url: URL(string: "google.com/superman")!,
            tags: ["Superman"]
        )

        let futureManagedGIFs = dataStore.fetchGIFsSortedByCreationDate()
        let managedGIFs = try self.waitAndExtractValue(future: futureManagedGIFs)

        guard let firstGIF = managedGIFs.first, let secondGIF = managedGIFs.last else {
            throw Error.objectUnwrappedFailed
        }

        XCTAssert(firstGIF.giphyID == SupermanID)
        XCTAssert(secondGIF.giphyID == JamesBondID)
    }

    //MARK: Private

    private func createAndFetch(giphyID: String, title: String, subtitle: String, url: URL, tags: Set<String>) throws -> ManagedGIF {
        try dataStore.createGIF(
            giphyID: giphyID,
            title: title,
            subtitle: subtitle,
            url: url,
            tags: tags
            ).blockingAwait(timeout: .seconds(1))

        guard let managedGIF = try dataStore.fetchGIF(id: giphyID) else {
            throw Error.objectUnwrappedFailed
        }

        return managedGIF
    }

    enum Error: Swift.Error {
        case objectUnwrappedFailed
    }
}

