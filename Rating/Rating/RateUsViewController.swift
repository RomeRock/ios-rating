//
//  RateUsViewController.swift
//  Rating
//
//  Created by NDM on 3/6/17.
//  Copyright © 2017 Rome Rock. All rights reserved.
//

import UIKit
import MessageUI

class RateUsViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet var oneStarButton: UIButton!
    @IBOutlet var twoStarButton: UIButton!
    @IBOutlet var threeStarButton: UIButton!
    @IBOutlet var fourStarButton: UIButton!
    @IBOutlet var fiveStarButton: UIButton!
    @IBOutlet var contentView: UIView!
    var stars:Int = 5
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func oneStarButtonPressed(_ sender: Any) {
        stars = 1
        oneStarButton.setImage(UIImage(named: "ic_full_star"), for: .normal)
        twoStarButton.setImage(UIImage(named: "ic_empty_star"), for: .normal)
        threeStarButton.setImage(UIImage(named: "ic_empty_star"), for: .normal)
        fourStarButton.setImage(UIImage(named: "ic_empty_star"), for: .normal)
        fiveStarButton.setImage(UIImage(named: "ic_empty_star"), for: .normal)
    }
    
    @IBAction func twoStarButtonPressed(_ sender: Any) {
        stars = 2
        oneStarButton.setImage(UIImage(named: "ic_full_star"), for: .normal)
        twoStarButton.setImage(UIImage(named: "ic_full_star"), for: .normal)
        threeStarButton.setImage(UIImage(named: "ic_empty_star"), for: .normal)
        fourStarButton.setImage(UIImage(named: "ic_empty_star"), for: .normal)
        fiveStarButton.setImage(UIImage(named: "ic_empty_star"), for: .normal)
    }
    
    @IBAction func threeStarButtonPressed(_ sender: Any) {
        stars = 3
        oneStarButton.setImage(UIImage(named: "ic_full_star"), for: .normal)
        twoStarButton.setImage(UIImage(named: "ic_full_star"), for: .normal)
        threeStarButton.setImage(UIImage(named: "ic_full_star"), for: .normal)
        fourStarButton.setImage(UIImage(named: "ic_empty_star"), for: .normal)
        fiveStarButton.setImage(UIImage(named: "ic_empty_star"), for: .normal)
    }
    
    @IBAction func fourStarButtonPressed(_ sender: Any) {
        stars = 4
        oneStarButton.setImage(UIImage(named: "ic_full_star"), for: .normal)
        twoStarButton.setImage(UIImage(named: "ic_full_star"), for: .normal)
        threeStarButton.setImage(UIImage(named: "ic_full_star"), for: .normal)
        fourStarButton.setImage(UIImage(named: "ic_full_star"), for: .normal)
        fiveStarButton.setImage(UIImage(named: "ic_empty_star"), for: .normal)
    }
    
    @IBAction func fiveStarButtonPressed(_ sender: Any) {
        stars = 5
        oneStarButton.setImage(UIImage(named: "ic_full_star"), for: .normal)
        twoStarButton.setImage(UIImage(named: "ic_full_star"), for: .normal)
        threeStarButton.setImage(UIImage(named: "ic_full_star"), for: .normal)
        fourStarButton.setImage(UIImage(named: "ic_full_star"), for: .normal)
        fiveStarButton.setImage(UIImage(named: "ic_full_star"), for: .normal)
    }

    
    @IBAction func rateNowButtonPressed(_ sender: Any) {
        UserDefaults.standard.set(stars, forKey: "starsRate")
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: .rate, object: nil)
        if stars > 3 {
            //open the app store to your app page for review :)
            let storeUrl = NSURL(string: "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=\(1190244008)")
            if UIApplication.shared.canOpenURL(storeUrl! as URL)
            {
                UIApplication.shared.open(storeUrl as! URL, options: [:], completionHandler: nil)
                
            }
        } else {
            //handle a low rating, avoid a bad review in the app store ;)
            let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.present(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func maybeLaterButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch? = touches.first
        let touchLocation = touch?.location(in: self.view)
        let contentViewFrame = self.view.convert(contentView.frame, from: contentView.superview)
        if !contentViewFrame.contains(touchLocation!) {
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["youremail@yourdomain.com"])
        mailComposerVC.setSubject("Rate - \(stars)/5")
        mailComposerVC.setMessageBody("", isHTML: false)
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let alertView = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ok", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertView.addAction(actionOk)
        present(alertView, animated: true, completion: nil)
    }
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: {
            self.dismiss(animated: true, completion: nil)
        })
        if result == MFMailComposeResult.sent {
            
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
