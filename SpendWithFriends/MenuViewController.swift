//
//  MainViewController.swift
//  HackathonApp
//
//  Created by Skiljan, Nicholas on 6/7/17.
//  Copyright © 2017 klangholm. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    var menuShowing = false
    
    @IBOutlet weak var settingsOption: UIButton!
    @IBOutlet weak var frequentOption: UIButton!
    @IBOutlet weak var upcomingOption: UIButton!
    @IBOutlet weak var possibleOption: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var menuView: UIView!
    override func viewWillAppear(_ animated: Bool) {
        self.menuView.frame = CGRect(x: -180, y: self.menuView.frame.origin.y, width: 175, height: self.menuView.frame.height)
        self.settingsOption.frame = CGRect(x: -180, y: self.settingsOption.frame.origin.y, width: 175, height: self.settingsOption.frame.height)
        self.frequentOption.frame = CGRect(x: -180, y: self.frequentOption.frame.origin.y, width: 175, height: self.frequentOption.frame.height)
        self.upcomingOption.frame = CGRect(x: -180, y: self.upcomingOption.frame.origin.y, width: 175, height: self.upcomingOption.frame.height)
        self.possibleOption.frame = CGRect(x: -180, y: self.possibleOption.frame.origin.y, width: 175, height: self.possibleOption.frame.height)

    }
    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewDidLoad()
        
        menuView.layer.shadowOpacity = 1
        menuView.layer.zPosition = 2
        menuButton.layer.zPosition = 3
        
        
    }
    @IBAction func buttonPressed(_ sender: Any) {
        if (menuShowing) {
            UIView.animate(withDuration: 0.3, animations: {
                self.menuView.frame = CGRect(x: -180, y: self.menuView.frame.origin.y, width: 175, height: self.menuView.frame.height)
                self.settingsOption.frame = CGRect(x: -180, y: self.settingsOption.frame.origin.y, width: 175, height: self.settingsOption.frame.height)
                self.frequentOption.frame = CGRect(x: -180, y: self.frequentOption.frame.origin.y, width: 175, height: self.frequentOption.frame.height)
                self.upcomingOption.frame = CGRect(x: -180, y: self.upcomingOption.frame.origin.y, width: 175, height: self.upcomingOption.frame.height)
                self.possibleOption.frame = CGRect(x: -180, y: self.possibleOption.frame.origin.y, width: 175, height: self.possibleOption.frame.height)
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.menuView.frame = CGRect(x: 0, y: self.menuView.frame.origin.y, width: 175, height: self.menuView.frame.height)
                self.settingsOption.frame = CGRect(x: 0, y: self.settingsOption.frame.origin.y, width: 175, height: self.settingsOption.frame.height)
                self.frequentOption.frame = CGRect(x: 0, y: self.frequentOption.frame.origin.y, width: 175, height: self.frequentOption.frame.height)
                self.upcomingOption.frame = CGRect(x: 0, y: self.upcomingOption.frame.origin.y, width: 175, height: self.upcomingOption.frame.height)
                self.possibleOption.frame = CGRect(x: 0, y: self.possibleOption.frame.origin.y, width: 175, height: self.possibleOption.frame.height)
            })
        }
        
        menuShowing = !menuShowing
    }
    
}
