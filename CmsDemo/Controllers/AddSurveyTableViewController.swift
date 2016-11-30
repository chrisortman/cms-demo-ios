//
//  AddSurveyTableViewController.swift
//  CmsDemo
//
//  Created by Ortman, Chris E on 11/30/16.
//  Copyright © 2016 chrisortman. All rights reserved.
//

import UIKit

class AddSurveyTableViewController: UITableViewController {

    @IBOutlet weak var newSurveyTitle: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
