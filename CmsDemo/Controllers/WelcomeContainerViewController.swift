//
//  WelcomeContainerViewController.swift
//  CmsDemo
//
//  Created by Ortman, Chris E on 12/2/16.
//  Copyright © 2016 chrisortman. All rights reserved.
//

import UIKit

protocol WelcomePageViewControllerDelegate : class {
    func textForAboutApp(welcomePageViewController: WelcomePageViewController) -> String
    func welcomePageViewController(welcomePageViewController: WelcomePageViewController, didUpdatePageCount count: Int)
    func welcomePageViewController(welcomePageViewController: WelcomePageViewController, didUpdatePageIndex index: Int)
}

class WelcomeContainerViewController: UIViewController, WelcomePageViewControllerDelegate {

    @IBOutlet weak var pageControl: UIPageControl!
    
    var model : AppInformation! = AppInformation(aboutText: "Yo!")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageController = segue.destination as? WelcomePageViewController {
            pageController.welcomeDelegate = self
            
        }
    }

    func textForAboutApp(welcomePageViewController: WelcomePageViewController) -> String {
        return self.model.aboutText
    }
    
    func welcomePageViewController(welcomePageViewController: WelcomePageViewController, didUpdatePageCount count: Int) {
        self.pageControl.numberOfPages = count
    }
    
    func welcomePageViewController(welcomePageViewController: WelcomePageViewController, didUpdatePageIndex index: Int) {
        self.pageControl.currentPage = index
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
