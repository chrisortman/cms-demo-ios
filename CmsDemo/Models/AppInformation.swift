//
//  AppInformation.swift
//  CmsDemo
//
//  Created by Ortman, Chris E on 12/2/16.
//  Copyright © 2016 chrisortman. All rights reserved.
//

import Foundation
import Unbox

struct AppInformation {
    
    let aboutText : String

}

extension AppInformation : Unboxable {
    init(unboxer : Unboxer) throws {
        self.aboutText = try unboxer.unbox(key: "aboutText")
    }
}
