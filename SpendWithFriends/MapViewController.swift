//
//  MapViewController.swift
//  SpendWithFriends
//
//  Created by Porupski, Luke on 6/7/17.
//  Copyright © 2017 klangholm. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {    
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.green
        
        //setUpMapView()
        

    }
    
    func setUpMapView(){
        
        //self.view.addSubview(mapView)
    }


}
