//
//  AppDataManagerSpec.swift
//  CmsDemo
//
//  Created by Ortman, Chris E on 12/3/16.
//  Copyright © 2016 chrisortman. All rights reserved.
//

import Quick
import Nimble

protocol CouchDatabase { }
protocol CouchDatabaseManager {
    var localCmsDatabaseExists : Bool { get }
    func createCmsMirrorDatabase() -> CouchDatabase
}

class AppDataManager {
    let couch : CouchDatabaseManager
    
    init(couch : CouchDatabaseManager) {
        self.couch = couch
    }
    
    func performUpdateCheck() {
        self.couch.createCmsMirrorDatabase()
    }
}

class FakeDatbaseManager : CouchDatabaseManager {
    var localCmsDatabaseExists: Bool = false
    
    
    var createdCmsDatabase = false
    
    func createCmsMirrorDatabase() -> CouchDatabase {
        createdCmsDatabase = true
        return FakeDatabase()
    }
    
}

class FakeDatabase : CouchDatabase { }

class AppDataManagerSpec : QuickSpec {
    override func spec() {
        let couch = FakeDatbaseManager()
        let mgr = AppDataManager(couch: couch)
        
        describe("perform update check") {
            
            it("creates local database if it is not present") {
                couch.localCmsDatabaseExists = false
                
                mgr.performUpdateCheck()
                expect(couch.createdCmsDatabase).to(equal(true))
            }
            
            
        }
    }
}
