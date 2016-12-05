//
//  EntryPointViewController.swift
//  CmsDemo
//
//  Created by Ortman, Chris E on 12/2/16.
//  Copyright © 2016 chrisortman. All rights reserved.
//

import UIKit
import PKHUD
import Unbox

class AppDataManager {
    
    let DB_NAME = "cms_mirror"
    let REMOTE_DB_URL = "http://localhost:5984/cms_backend"
    
    private let manager = CBLManager.sharedInstance()
    private var db : CBLDatabase?
    private var replication : CBLReplication?
    private var completionCallback : ((CBLDatabase?) -> Void)?
    
    func ensureUpToDate(updateComplete completion: @escaping (CBLDatabase?) -> Void) {
        
        self.completionCallback = completion
        var needsUpdate = true
        let options = CBLDatabaseOptions()
        
        if !manager.databaseExistsNamed(DB_NAME) {
            options.create = true
            needsUpdate = true
        }
        
        self.db = try! manager.openDatabaseNamed(DB_NAME, with: options)
        
        if needsUpdate {
            let url = URL(string: REMOTE_DB_URL)!
            
            self.replication = db!.createPullReplication(url)
            replication!.continuous = false
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(AppDataManager.replicationChanged(_:)), name: NSNotification.Name.cblReplicationChange, object: replication)
            
            
            HUD.show(.labeledProgress(title: "Just a moment while we set things up", subtitle: nil))
            replication!.start()
        } else {
            self.completionCallback?(self.db)
        }
            
    
       
    }
    
    @objc private func replicationChanged(_ n: Notification) {
        switch self.replication?.status {
        case .stopped?, .offline?, .idle?:
            HUD.hide()
            self.dumpDebugDatabase()
            self.completionCallback?(self.db)
        default:
            break
        }
        
    }
    
    private func dumpDebugDatabase() {
        guard let db = self.db else { return }
        
        let sharedPush = db.createPushReplication(URL(string:  "http://localhost:5984/device_debug_cms_backend")!)
        sharedPush.start()
    }
    
}


class EntryPointViewController: UIViewController {

    let dbInit = AppDataManager()
    var cmsDatabase : CBLDatabase?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.performSegue(withIdentifier: "ShowWelcomeSegue", sender: self)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbInit.ensureUpToDate {
            self.cmsDatabase = $0
            self.displayWelcome()
        }
        
               // Do any additional setup after loading the view.
    }

    private func displayWelcome() {
        // Have to force a run loop or this won't show up :(
        DispatchQueue.main.async {
            let welcome = self.storyboard!.instantiateViewController(withIdentifier: "WelcomeStart") as! WelcomeContainerViewController
            
            if let doc = self.cmsDatabase?.existingDocument(withID: "appInformation_2_1") {
                let data = doc["data"] as! [String : Any]
                let appInfo : AppInformation? = try? unbox(dictionary: data)
                welcome.model = appInfo ?? AppInformation(aboutText: "Error reading database")
//                welcome.model = try! unbox(dictionary: doc["data"])
            }
            
            self.present(welcome, animated: false, completion: nil)
            
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
