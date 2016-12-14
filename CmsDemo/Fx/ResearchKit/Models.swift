//
// Created by Chris Ortman on 12/13/16.
// Copyright (c) 2016 chrisortman. All rights reserved.
//

import Foundation
import ResearchKit
import Unbox

struct ConsentSectionDefinition {
    let title : String
    let type : ORKConsentSectionType
    let summary : String
    let learnMoreButtonTitle : String
    let htmlContent : String

}

struct ConsentDocumentDefinition {
    let title : String
    let sections : [ConsentSectionDefinition]
}

extension ConsentDocumentDefinition : Unboxable {
    init(unboxer: Unboxer) throws {
        self.title = try unboxer.unbox(key: "title")
        self.sections = try unboxer.unbox(key: "sections")
    }
}

extension ConsentSectionDefinition : Unboxable {
    init(unboxer: Unboxer) throws {
        self.title = try unboxer.unbox(key: "title")
        self.type = .custom
        self.summary = try unboxer.unbox(key: "summary")
        self.learnMoreButtonTitle = try unboxer.unbox(key: "learnMoreButtonTitle")
        self.htmlContent = try unboxer.unbox(key: "htmlContent")
    }
}
