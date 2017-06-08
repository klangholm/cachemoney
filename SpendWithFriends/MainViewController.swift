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

class MainViewController: UIViewController, SlideMenuDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var mapViewController: MapViewController?
    var mapView: UIView?
    var locationManager = CLLocationManager()
    
    var meetupsView = UIView()
    
    var requestsView = UIView()
    
    var settingsView = UIView()
    
    var menu: SlideMenu?
    var selectedView: selectedMode = .discover
    var dataHandler = DataHandler()
    var containerView:UIView = {
        let v = UIView()
        
        v.frame = CGRect.zero
        
        v.isHidden = true
        return v
    }()
    
    @IBOutlet weak var menuButton: UIButton!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationItem.title = "Discover"
        dataHandler.getPurchases()
        
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
        map.delegate = self
        map.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        
        //Check for Location Services
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        if let loc = locationManager.location?.coordinate {
            
            let viewRegion = MKCoordinateRegionMakeWithDistance(loc, 200, 200)
            map.setRegion(viewRegion, animated: true)
        }
        else {
            let loc = CLLocationCoordinate2D(latitude: 37.5407, longitude: -77.4360)
            
            let viewRegion = MKCoordinateRegionMakeWithDistance(loc, 200, 200)
            map.setRegion(viewRegion, animated: true)
        }
        
        
        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }
        
        
        meetupsView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        containerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        containerView.backgroundColor = UIColor.yellow
        self.view.addSubview(containerView)
        
    }
    
    @IBAction func didTapMenuButton() {
        self.menu?.toggle()
    }
    
    
    func didUpdateViewStatus(toStatus: selectedMode) {
        self.selectedView = toStatus
        switch toStatus {
        case .discover:
            self.navigationItem.title = "Discover"
            containerView.isHidden = true
            break
        case .meetups:
            self.navigationItem.title = "Meetups"
            containerView.backgroundColor = UIColor.blue
            containerView.isHidden = false
            break
        case .requests:
            self.navigationItem.title = "Requests"
            containerView.backgroundColor = UIColor.red
            containerView.isHidden = false
            break
        case .settings:
            self.navigationItem.title = "Settings"
            containerView.backgroundColor = UIColor.cyan
            containerView.isHidden = false
            break
        }
    }
    
    
}
