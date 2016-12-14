//
//  WelcomeContainerViewController.swift
//  CmsDemo
//
//  Created by Ortman, Chris E on 12/2/16.
//  Copyright © 2016 chrisortman. All rights reserved.
//

import UIKit
import ResearchKit

protocol WelcomePageViewControllerDelegate : class {
    func textForAboutApp(welcomePageViewController: WelcomePageViewController) -> String
    func welcomePageViewController(welcomePageViewController: WelcomePageViewController, didUpdatePageCount count: Int)
    func welcomePageViewController(welcomePageViewController: WelcomePageViewController, didUpdatePageIndex index: Int)
}

private extension ORKConsentSection {
    convenience init(_ type: ORKConsentSectionType, title: String, summary: String) {
        self.init(type: type)
        self.title = title
        self.summary = summary
    }
}

struct ConsentProcess {

    let doc = ORKConsentDocument()
    let signature = ORKConsentSignature(
            forPersonWithTitle: nil,
            dateFormatString: nil,
            identifier: "ConsentDocumentParticipantSignature"
    )

    func buildTask() -> ORKTask {

        doc.title = "Study Review"
        doc.sections = [
                ORKConsentSection(.overview, title: "Overview", summary: "Read this please"),
                ORKConsentSection(.dataGathering, title: "All your data will belong to us", summary: "It's not like you haven't already given it to facebook, who cares anyway")
        ]


        doc.addSignature(signature)

        let informStep = ORKVisualConsentStep(identifier: "Onboarding.Consent.Document", document: doc)
        let reviewStep = ORKConsentReviewStep(identifier: "Onboarding.Consent.Review", signature: signature, in: doc)
        reviewStep.reasonForConsent = "So we may own your immortal soul"

        let registrationStep = ORKRegistrationStep(
                identifier: "Onboarding.Consent.Registration",
                title: "Registration",
                text: nil,
                options: []
        )

        let task = ORKOrderedTask(identifier: "Onboarding.Consent", steps: [
                informStep, reviewStep, registrationStep
        ])

        return task

    }
}

struct ConsentResult {

    let taskResult : ORKTaskResult
    init(from: ORKTaskResult) {
        self.taskResult = taskResult
    }

    var agreed : Bool {
        return true
    }

    var accountValid : Bool {
        return true
    }
}

class WelcomeContainerViewController: UIViewController, WelcomePageViewControllerDelegate, ORKTaskViewControllerDelegate {

    @IBOutlet weak var pageControl: UIPageControl!
    
    var model : AppInformation! = AppInformation(aboutText: "Yo!")
    
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

    @IBAction func joinStudyClicked(_ sender: Any) {
        let process = ConsentProcess()
        let taskController = ORKTaskViewController(task: process.buildTask(), taskRun: nil)
        taskController.delegate = self
        self.present(taskController, animated: true, completion: nil)
    }
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {

        switch reason {
            case .completed:

                let result = ConsentResult(from: taskViewController.result)
                if result.agreed && result.accountValid {
                    //enroll user on the server
                }

            default:
                self.dismiss(animated: true, completion: nil)

        }
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
