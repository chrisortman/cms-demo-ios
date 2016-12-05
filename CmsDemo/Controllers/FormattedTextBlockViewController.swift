//
//  FormattedTextBlockViewController.swift
//  CmsDemo
//
//  Created by Ortman, Chris E on 12/2/16.
//  Copyright © 2016 chrisortman. All rights reserved.
//

import UIKit
import Stevia

class FormattedTextBlockViewController: UIViewController {

    var titleText : String = "Formatted Text"
    var bodyText : String = "This is some formatted text"
    
    private let titleLabel = UILabel()
    private let textControl = UITextView()
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func loadView() {
        
        super.loadView()
        
        titleLabel.text = self.titleText
        textControl.text = self.bodyText
        
        titleLabel.style { l in
            l.font = UIFont.systemFont(ofSize: 16)
        }
        
        textControl.style { l in
            l.backgroundColor = .green
        }
        
        self.view.sv( titleLabel, textControl )
        
        
        self.view.layout(
            40,
            titleLabel.centerHorizontally(),
            11,
            |-textControl-|,
            0
        )

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
