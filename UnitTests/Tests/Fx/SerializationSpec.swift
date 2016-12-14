//
// Created by Chris Ortman on 12/13/16.
// Copyright (c) 2016 chrisortman. All rights reserved.
//

import XCTest
import Nimble
import Wrap
import ResearchKit
import Unbox

@testable import CmsDemo

private extension ConsentSectionDefinition {
    init(titledForTest: String) {
         self.init(title: titledForTest,
                   type: .custom,
                   summary: "Summary",
                   learnMoreButtonTitle: "Learn More",
                   htmlContent: "<p></p>"
                
                )
    }
}

class SerializationSpec : XCTestCase {

    func testConsentDocumentSerialization() {

        let doc = ConsentDocumentDefinition(title: "Test Doc", sections: [
                ConsentSectionDefinition(titledForTest: "Section 1"),
                ConsentSectionDefinition(titledForTest: "Section 2"),
        ])

        let json : [String : Any] = try! wrap(doc)
        
        let deserialized : ConsentDocumentDefinition = try! unbox(dictionary: json)
        expect(deserialized.title).to(equal("Test Doc"))
        expect(deserialized.sections.count).to(equal(2))
    }

}
