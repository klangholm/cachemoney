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

class MainViewController: UIViewController, SlideMenuDelegate, MKMapViewDelegate, CLLocationManagerDelegate, MapDataDelegate {
    
    var mapViewController: MapViewController?
    var mapView: UIView?
    var locationManager = CLLocationManager()
    
    var overlayView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    var meetupsView = UIView()
    
    var requestsView = UIView()
    
    var settingsView = UIView()
    
    var map: MKMapView?
    
    var purchases = [Purchase]()
    
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
    
    var merchants = [Merchant]()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationItem.title = "Discover"
        dataHandler.mapDelegate = self
        dataHandler.getPurchases()
        
        if purchases.count == 0 {
            overlayView.backgroundColor = UIColor(colorLiteralRed: 0/255, green: 0/255, blue: 0/255, alpha: 0.9)
            
            SwiftSpinner.show("Discovering new people...")
            
        }
    }
    
    func didRetrieveUserPurchaseData(purchases: [Purchase]){
        self.purchases = purchases
        self.dataHandler.getMerchantsFromPurchases(purchases: purchases)
        self.addPins()
    }
    
    func didRetrieveGeoData(m: [Merchant]) {
        SwiftSpinner.hide()
        self.merchants = m
        OperationQueue.main.addOperation({
            self.addPins()
        })

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
    
    func addPins() {
        for merchant in merchants {
            //let customPin = customMapPinView(merchant: merchant)
            //customPin
            
            let point = CustomPointAnnotation()
            point.merchant = merchant
            point.title = merchant.name
            point.coordinate = CLLocationCoordinate2D(latitude: merchant.latitude, longitude: merchant.longitude)
            let pinAnnotation = MKPinAnnotationView(annotation: point, reuseIdentifier: "Pin")
            self.map!.addAnnotation(pinAnnotation.annotation!)
            
        }
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
        map = MKMapView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.view.addSubview(map!)
        map?.delegate = self
        map?.showsUserLocation = true
        map?.showsPointsOfInterest = false
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
            
            let viewRegion = MKCoordinateRegionMakeWithDistance(loc, 1000, 1000)
            //map?.setCenter(loc, animated: true)
            map?.setRegion(viewRegion, animated: true)
        }
        else {
            let loc = CLLocationCoordinate2D(latitude: 37.5407, longitude: -77.4360)
            
            let viewRegion = MKCoordinateRegionMakeWithDistance(loc, 1000, 1000)
            map?.setRegion(viewRegion, animated: true)
        }
        
        
        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }
        
        
        meetupsView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        containerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        containerView.backgroundColor = UIColor.yellow
        self.view.addSubview(containerView)
        
        
        //meetups
        
        let mvc = self.storyboard?.instantiateViewController(withIdentifier: "meetUpTableViewController") as! MeetUpTableViewController
        
        //self.addChildViewController(mvc)
        mvc.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        //self.view.addSubview(mvc.view)
        //self.meetupsView = mvc.view
        
        //self.meetupsView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        
        //requests
        
        
        
        
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
            
            containerView = meetupsView
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
    
    //map view methods
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let ann = view.annotation as? CustomPointAnnotation {
            let x = ann.merchant
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let ann = view.annotation as? CustomPointAnnotation {
            let x = ann.merchant
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "profileTableViewController") as! ProfileTableViewController
            vc.selectedMerchant = x
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "Pin"
        var annotationView = map?.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        let customPointAnnotation = annotation as! CustomPointAnnotation
        //annotationView?.merchant =
        //annotationView?.image = UIImage(named: customPointAnnotation.pinCustomImageName)
        
        return annotationView
    }
    
    
    


}
