//
//  GifWalletUITests.swift
//  GifWalletUITests
//
//  Created by Jordi Serra i Font on 1/4/18.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import XCTest

class GifWalletUITests: XCTestCase {
    
    var app: XCUIApplication!
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testShowingGIFWallet() {
        //Check if the wallet is displayed
        XCTAssertTrue(app.isDisplayingGIFWallet)
        
        //Check if the add button is displayed
        XCTAssertTrue(app.buttons["Add"].exists)
    }
    
    func testTapAddShowsGIFCreateView() {
        app.navigationBars["Your GIFs"].buttons["Add"].tap()
        XCTAssertFalse(app.isDisplayingGIFWallet)
        XCTAssertTrue(app.isDisplayingGIFCreate)
        
        
    }
    
    func testTapGifEmptyViewShowsGIFSearchView() {
        app.navigationBars["Your GIFs"].buttons["Add"].tap()
        app/*@START_MENU_TOKEN@*/.tables/*[[".otherElements[\"GIFCreateView\"].tables",".tables"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .cell).element(boundBy: 0).children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .image).element.tap()
        XCTAssertFalse(app.isDisplayingGIFWallet)
        XCTAssertFalse(app.isDisplayingGIFCreate)
        XCTAssertTrue(app.isDisplayingGIFSearch)
    }
    
    func testWriteSomethingInTitleShowsTitleInGifCreate() {
        
        app.navigationBars["Your GIFs"].buttons["Add"].tap()
        let titleField = app/*@START_MENU_TOKEN@*/.tables.textFields["Enter the Title"]/*[[".otherElements[\"GIFCreateView\"].tables",".cells.textFields[\"Enter the Title\"]",".textFields[\"Enter the Title\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
        titleField.tap()
        titleField.typeText("Something")
        app.toolbars["Toolbar"].buttons["Toolbar Done Button"].tap()
        
        XCTAssertTrue(app.tables.textFields["Something"].exists)
    }
    
    func testWriteSomethingInSubtitleShowsSubtitleInGifCreate() {
        
        app.navigationBars["Your GIFs"].buttons["Add"].tap()
        let subtitleField = app/*@START_MENU_TOKEN@*/.tables.textFields["Enter the Subtitle"]/*[[".otherElements[\"GIFCreateView\"].tables",".cells.textFields[\"Enter the Subtitle\"]",".textFields[\"Enter the Subtitle\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
        subtitleField.tap()
        subtitleField.typeText("Something")
        app.toolbars["Toolbar"].buttons["Toolbar Done Button"].tap()
        
        XCTAssertTrue(app.tables.textFields["Enter the Title"].exists)
        XCTAssertTrue(app.tables.textFields["Something"].exists)
        XCTAssertTrue(app.tables.textFields["Intro Tag Here"].exists)
    }
    
    func testAddNewGIFImageShowsGIFCreate() {
        
        app.navigationBars["Your GIFs"].buttons["Add"].tap()
        //Tap the image to add
        app.images["GIFImageToAdd"].tap()
        //Tap first row of search
        app/*@START_MENU_TOKEN@*/.collectionViews/*[[".otherElements[\"GIFSearchView\"].collectionViews",".collectionViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.tap()
        
        XCTAssertTrue(app.isDisplayingGIFCreate)
        
    }
    
    func testCreateAndCancelShowsGIFWalletView() {
        
        app.navigationBars["Your GIFs"].buttons["Add"].tap()
        app.navigationBars["GifWallet.GIFCreateView"].buttons["Cancel"].tap()
        
        XCTAssertTrue(app.isDisplayingGIFWallet)
    }
    
    func testCreateTapGifAndBackDisplaysCreateView() {
        
        app.navigationBars["Your GIFs"].buttons["Add"].tap()
        app/*@START_MENU_TOKEN@*/.tables.images["GIFImageToAdd"]/*[[".otherElements[\"GIFCreateView\"].tables",".cells.images[\"GIFImageToAdd\"]",".images[\"GIFImageToAdd\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["GifWallet.GIFSearchView"].buttons["Back"].tap()
        
        XCTAssertTrue(app.isDisplayingGIFCreate)
    }
    
    func testTapFirstItemInGIFWalletShowsGIFDetailsView() {
        //TODO: fill the database with at least one GIF
    }
}

extension XCUIApplication {
    var isDisplayingGIFWallet: Bool {
        return otherElements["GIFWalletView"].exists
    }
    
    var isDisplayingGIFCreate: Bool {
        return otherElements["GIFCreateView"].exists
    }
    
    var isDisplayingGIFSearch: Bool {
        return otherElements["GIFSearchView"].exists
    }
}
