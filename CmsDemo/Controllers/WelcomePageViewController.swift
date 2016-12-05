//
//  WelcomePageViewController.swift
//  CmsDemo
//
//  Created by Ortman, Chris E on 12/2/16.
//  Copyright © 2016 chrisortman. All rights reserved.
//

import UIKit

class WelcomePageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    lazy var aboutStudyPage : FormattedTextBlockViewController = FormattedTextBlockViewController()
    lazy var aboutAppPage : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "AboutAppPage")
    
    var model : AppInformation!
    weak var welcomeDelegate : WelcomePageViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        aboutStudyPage.bodyText = self.welcomeDelegate?.textForAboutApp(welcomePageViewController: self) ?? "About this app"
        
        self.setViewControllers([aboutStudyPage], direction: .forward, animated: true, completion: nil)
        self.welcomeDelegate?.welcomePageViewController(welcomePageViewController: self, didUpdatePageCount: 2)
        // Do any additional setup after loading the view.
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let vc = previousViewControllers.first {
            if vc === aboutStudyPage {
                self.welcomeDelegate?.welcomePageViewController(welcomePageViewController: self, didUpdatePageIndex: 1)
            } else {
                self.welcomeDelegate?.welcomePageViewController(welcomePageViewController: self, didUpdatePageIndex: 0)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController === aboutStudyPage {
            return aboutAppPage
        } else if viewController === aboutAppPage {
            return aboutStudyPage
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController === aboutStudyPage {
            return aboutAppPage
        } else if viewController === aboutAppPage {
            return aboutStudyPage
        } else {
            return nil
        }
    }

}
