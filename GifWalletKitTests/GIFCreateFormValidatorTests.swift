//
//  Created by Jordi Serra i Font on 27/3/18.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import XCTest
import GifWalletKit

class GIFFormValidatorTests: XCTestCase {

    var formValidator: GIFCreateFormValidator!

    override func setUp() {
        super.setUp()
        formValidator = GIFCreateFormValidator()
    }

    func testRequiredSections() {
        XCTAssert(formValidator.requiredSections.count == 4)
        XCTAssert(formValidator.requiredSections[0] == .gifURL)
        XCTAssert(formValidator.requiredSections[1] == .title)
        XCTAssert(formValidator.requiredSections[2] == .subtitle)
        XCTAssert(formValidator.requiredSections[3] == .tags)
    }

    func testValidateInvalidResults() {

        let title: String? = nil
        let subtitle = ""
        let gifURL = URL(string: "invalid URL")
        let tags = [String]()

        formValidator.form.title = title
        formValidator.form.subtitle = subtitle
        formValidator.form.gifURL = gifURL
        formValidator.form.tags = tags

        let result = formValidator.validateForm()

        switch result {
        case .ok:
            XCTFail("Result should be an error")
        case .error(let errors):
            XCTAssert(errors.count == 4, "Validation must contain exactly 4 errors")
            XCTAssert(errors.contains(.titleNotProvided), "Validation result must contain error: title not provided")
            XCTAssert(errors.contains(.subtitleNotProvided), "Validation result must contain error: subtitle not provided")
            XCTAssert(errors.contains(.gifNotProvided), "Validation result must contain error: gif not provided")
            XCTAssert(errors.contains(.tagsNotProvided), "Validation result must contain error: tags not provided")
        }
    }

    func testValidateValidResults() {

        let title: String? = "A GIF Title"
        let subtitle = "A GIF Subtitle"
        let gifURL = URL(string: "https://media0.giphy.com/media/8752sSo2HbPqE7MN03/giphy.gif")
        let tags = [ "funny" ]

        formValidator.form.title = title
        formValidator.form.subtitle = subtitle
        formValidator.form.gifURL = gifURL
        formValidator.form.tags = tags

        switch formValidator.validateForm() {
        case .ok:
            break
        default:
            XCTFail()
        }
    }

}
