//
//  Created by Jordi Serra i Font on 27/3/18.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import Foundation

public final class GIFCreateFormValidator {

    public init() {
        requiredSections = [
            .gifURL,
            .title,
            .subtitle,
            .tags
        ]
    }
    
    public let form = Form()
    public let requiredSections: [Section]

    public enum Section {
        case title
        case subtitle
        case gifURL
        case tags
    }

    public class Form {
        public var title: String?
        public var subtitle: String?
        public var gifURL: URL?
        public var tags: [String]?

        init() { }
    }

    public enum ValidationResult {
        case ok
        case error(Set<ValidationError>)
    }

    public enum ValidationError: Error {
        case titleNotProvided
        case subtitleNotProvided
        case gifNotProvided
        case tagsNotProvided
    }

    public func validateForm() -> ValidationResult {

        func isEmpty(_ string: String?) -> Bool {
            return string == nil || string!.isEmpty
        }

        var errors = Set<ValidationError>()

        if isEmpty(form.title) {
            errors.insert(.titleNotProvided)
        }

        if isEmpty(form.subtitle) {
            errors.insert(.subtitleNotProvided)
        }

        if form.gifURL == nil {
            errors.insert(.gifNotProvided)
        }

        if form.tags == nil || form.tags!.isEmpty {
            errors.insert(.tagsNotProvided)
        }

        if errors.isEmpty {
            return .ok
        } else {
            return .error(errors)
        }
    }
}
