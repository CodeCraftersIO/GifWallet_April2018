//
//  GifWalletUITests.swift
//  GifWalletUITests
//
//  Created by Pierluigi Cifani on 02/04/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import XCTest

class GifWalletUITests: XCTestCase {

    var app = XCUIApplication()
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }
    
    func testCreateGIF() {

        let title = "Hola"
        let subtitle = "Mundo"
        let tag = "Sun"

        app.navigationBars["Your GIFs"].buttons["Add"].tap()
        cellInTableView(cellIndex: 0, app: app).tap()
        cellInCollectionView(cellIndex: 0, app: app).tap()
        app.tables.textFields["Enter the Title"].tap()

        typeString(string: title, app: app)
        tapNextButtonOnKeyboard(app: app)
        typeString(string: subtitle, app: app)
        tapNextButtonOnKeyboard(app: app)
        typeString(string: tag, app: app)
        app.buttons["Return"].tap()
        app.buttons["Save"].tap()

        let firstCell = cellInCollectionView(cellIndex: 0, app: app)
        guard let firstCellAccesibility = firstCell.value as? String else {
            XCTFail()
            return
        }
        
        XCTAssert(firstCellAccesibility == "Hola")
    }

    func testFailCreateGIF() {
        app.navigationBars["Your GIFs"].buttons["Add"].tap()
        app.buttons["Save"].tap()

        let firstCell = cellInTableView(cellIndex: 0, app: app)
        guard let firstCellAccesibility = firstCell.value as? String else {
            XCTFail()
            return
        }

        XCTAssert(firstCellAccesibility == "Error")
    }
}


func tapNextButtonOnKeyboard(app: XCUIApplication) {
    let toolbarNextButtonButton = app.toolbars["Toolbar"].buttons["Toolbar Next Button"]
    toolbarNextButtonButton.tap()
}

func typeString(string: String, app: XCUIApplication) {
    for char in string {
        let key = app.keyboards.keys[String(char)]
        key.tap()
    }
}

func cellInTableView(cellIndex: Int, app: XCUIApplication) -> XCUIElement {
    return app.tables.children(matching: .cell).element(boundBy: cellIndex)
}

func cellInCollectionView(cellIndex: Int, app: XCUIApplication) -> XCUIElement {
    return app.collectionViews.children(matching: .cell).element(boundBy: cellIndex)
}
