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
    @IBOutlet weak var menuView: UIView!
    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewDidLoad()
        
        menuView.layer.shadowOpacity = 1
    }
    @IBAction func buttonPressed(_ sender: Any) {
        if (menuShowing) {
            UIView.animate(withDuration: 0.3, animations: {
                self.menuView.frame = CGRect(x: -140, y: self.menuView.frame.origin.y, width: 140, height: self.menuView.frame.height)
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.menuView.frame = CGRect(x: 0, y: self.menuView.frame.origin.y, width: 140, height: self.menuView.frame.height)
            })
        }
        
        menuShowing = !menuShowing
    }
    
}
