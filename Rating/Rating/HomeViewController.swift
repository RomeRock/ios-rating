//
//  HomeViewController.swift
//  Rating
//
//  Created by NDM on 3/5/17.
//  Copyright © 2017 Rome Rock. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet var menuItem: UIBarButtonItem!
    @IBOutlet var contentView: UIView!
    var titleLabel:UILabel!
    
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var starsStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if self.revealViewController() != nil {
            menuItem.target = self.revealViewController()
            menuItem.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.revealViewController().panGestureRecognizer().delegate = self
        }
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
        contentView.layer.shadowOpacity = 0.4
        contentView.layer.shadowRadius = 0
        contentView.layer.cornerRadius = 2
        
        titleLabel = UILabel()
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.white
        titleLabel.text = "MM: Rate us"
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
        
        updateRating()
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.updateRating), name: .rate, object: nil)
    }
    
    func updateRating() {
        if UserDefaults.standard.object(forKey: "starsRate") != nil {
            let stars = UserDefaults.standard.integer(forKey: "starsRate")
            descriptionLabel.isHidden = true
            for (index, element) in starsStackView.arrangedSubviews.enumerated() {
                let imageView:UIImageView = element as! UIImageView
                if (index + 1) <=  stars {
                    imageView.image = UIImage(named: "ic_full_star")
                } else {
                    imageView.image = UIImage(named: "ic_empty_star")
                }
            }
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
