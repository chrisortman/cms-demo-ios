//
//  SurveyListTableViewController.swift
//  CmsDemo
//
//  Created by Ortman, Chris E on 11/30/16.
//  Copyright © 2016 chrisortman. All rights reserved.
//

import UIKit

func createDatabase() -> CBLDatabase {
    let dbname = "cms_local"
    let options = CBLDatabaseOptions()
    options.create = true
    
    return try! CBLManager.sharedInstance().openDatabaseNamed(dbname, with: options)
}

class SurveyListTableViewController: UITableViewController {

    var surveyQuery : CBLLiveQuery!
    var surveysTitles : [CBLQueryRow]?
    
    lazy var database = createDatabase()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        setupViewAndQuery()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViewAndQuery() {
        let listsView = database.viewNamed("list/surveysByTitle")
        if listsView.mapBlock == nil {
            listsView.setMapBlock({ (doc,emit) in
                if let id = doc["_id"] as? String, id.hasPrefix("survey") {
                    
                    if let data = doc["data"] as? [String : AnyObject] {
                        if let title = data["title"] as? String {
                                emit(title, nil)
                        }
                    }
                    
                }
            }, version: "1.0")
        }
        
        surveyQuery = listsView.createQuery().asLive()
        surveyQuery.addObserver(self, forKeyPath: "rows", options: .new, context: nil)
        surveyQuery.start()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return surveysTitles?.count ?? 0
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object as? NSObject == surveyQuery {
            reloadSurveys()
        }
    }
    
    func reloadSurveys() {
        surveysTitles = surveyQuery.rows?.allObjects as? [CBLQueryRow] ?? nil
        tableView.reloadData()
    }

    @IBAction func unwindFromAddSurvey(segue : UIStoryboardSegue) {
        if let addController = segue.source as? AddSurveyTableViewController {
            
            let properties : [String : Any] = [
                "data" : [
                    "title" : addController.newSurveyTitle.text ?? "",
                    "question" : []
                ]
            ]
            let id = "survey_2_\(NSUUID().uuidString)"
            
            let doc = database.document(withID: id)!
            try! doc.putProperties(properties)
            
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let row = self.surveysTitles![indexPath.row] as CBLQueryRow
        cell.textLabel?.text = row.value(forKey: "key") as? String

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
