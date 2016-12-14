//
// Created by Chris Ortman on 12/13/16.
// Copyright (c) 2016 chrisortman. All rights reserved.
//

import Foundation
import ResearchKit

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