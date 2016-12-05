//
//  AppDelegate.swift
//  CmsDemo
//
//  Created by Ortman on 11/30/16
//  Copyright (c) 2016 chrisortman. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    lazy var database = createDatabase()
    var pusher : CBLReplication!
    var puller : CBLReplication!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    
//        let url = URL(string: "http://localhost:5984/mobile_backend")!
//        
//        pusher = database.createPushReplication(url)
//        pusher.continuous = true
//        puller = database.createPullReplication(url)
//        puller.continuous = true
//        
//        pusher.start()
//        puller.start()
        
        return true
    }
}
