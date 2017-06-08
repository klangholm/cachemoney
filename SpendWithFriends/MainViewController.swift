//
//  MainViewController.swift
//  SpendWithFriends
//
//  Created by Porupski, Luke on 6/7/17.
//  Copyright © 2017 klangholm. All rights reserved.
//

import UIKit
import MapKit

public enum selectedMode {
    case discover
    case meetups
    case requests
    case settings
}

class MainViewController: UIViewController, SlideMenuDelegate {
    
    var mapViewController: MapViewController?
    var mapView: UIView?
    
    var meetupsView = UIView()
    
    var requestsView = UIView()
    
    var settingsView = UIView()
    
    var menu: SlideMenu?
    var selectedView: selectedMode = .discover
    
    @IBOutlet weak var menuButton: UIButton!
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationItem.title = "Discover"

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = UIColor.blue
        self.navigationController?.navigationBar.isTranslucent = false
        
        
        let button = UIBarButtonItem(title: "menu", style: .done, target: self, action: #selector(didTapMenuButton))
        let mButton = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        mButton.setBackgroundImage(UIImage(named: "hamburger.png"), for: .normal)
        mButton.addTarget(self, action: #selector(didTapMenuButton), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: mButton)
        self.navigationItem.setLeftBarButton(barButton, animated: true)
        self.navigationController?.title = "Discover"
    
        
        setUpControllers()
        setUpMenu()
        
    }
    
    func setUpMenu() {
        menu = SlideMenu(frame: CGRect(x: -140, y: 0, width: 140, height: self.view.frame.height))
        menu?.layer.zPosition = 4
        self.view.addSubview(menu!)
        menu?.delegate = self
    }
    
    func setUpControllers() {
        
        //set up map controller
        mapViewController = self.storyboard?.instantiateViewController(withIdentifier: "mapViewController") as! MapViewController
        
        mapView = mapViewController?.view
        mapView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.backgroundColor = UIColor.green
        let map = MKMapView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.view.addSubview(map)
        
        meetupsView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        
        
    }

    @IBAction func didTapMenuButton() {
        self.menu?.toggle()
    }
    
    
    func didUpdateViewStatus(toStatus: selectedMode) {
        self.selectedView = toStatus
        switch toStatus {
        case .discover:
            self.navigationItem.title = "Discover"
            break
        case .meetups:
            self.navigationItem.title = "Meetups"
            break
        case .requests:
            self.navigationItem.title = "Requests"
            break
        case .settings:
            self.navigationItem.title = "Settings"
            break
        }
    }


}
