//
//  MapTabViewController.swift
//  AllinOne
//
//  Created by flash on 10/27/23.
//  Copyright © 2023 flash. All rights reserved.
//

import UIKit
import MapKit

class MapTabViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var lat:Double = CommonData.shared.lat
    var long:Double = CommonData.shared.long
    var cityName:String = CommonData.shared.cityName
    
    
    let region_radious = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print(lat," ",long)
        let latitude:CLLocationDegrees = CLLocationDegrees (lat)     //23.803612692466704
        let longitude:CLLocationDegrees = CLLocationDegrees (long)
        
        centreMap(latitude: latitude, longitude: longitude, mapView: mapView,cityName: cityName,region_radious: region_radious)
        
    }
    
    

    
}
