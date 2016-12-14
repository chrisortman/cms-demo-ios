//
// Created by Chris Ortman on 12/13/16.
// Copyright (c) 2016 chrisortman. All rights reserved.
//

import Quick
import Nimble
import Wrap
@testable import CmsDemo

private extension ConsentSectionDefinition {
    convenience init(titledForTest: String) {
        return ConsentSectionDefinition(title: titledForTest,
                htmlContent: "<p></p>",
                learnMoreButtonTitle: "Learn More",
                summary: "Summary")
    }
}

class SerializationSpec : QuickSpec {
    override func spec() {
        describe("Converting consent doc to / from JSON") {
            it("works") {
                let doc = ConsentDocumentDefinition(title: "Test Doc", sections: [
                    ConsentSectionDefinition(titledForTest: "Section 1")
                ])

                let json = wrap(doc)
                let deserialized : ConsentDocumentDefinition = unbox(data: json)
                expect(deserialized.title).to(eq("Test Doc"))
                expect(deserialized.sections.count).to(eq(1))
            }
        }
    }
}
