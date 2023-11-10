//
//  MapViewController.swift
//  AllinOne
//
//  Created by flash on 10/11/23.
//  Copyright © 2023 flash. All rights reserved.
//

import UIKit
import  MapKit
class MapViewController: UIViewController {
    
    //22.454006705307076, 89.0337393778285
    @IBOutlet weak var mapView: MKMapView!
    var lat:Double = CommonData.shared.lat
     var long:Double = CommonData.shared.long
     var cityName:String = CommonData.shared.cityName
     
    let region_radious = 100
    override func viewDidLoad() {
        super.viewDidLoad()
        let latitude:CLLocationDegrees = CLLocationDegrees (lat)     //23.803612692466704
               let longitude:CLLocationDegrees = CLLocationDegrees (long)
        centreMap(latitude: latitude, longitude: longitude,mapView: mapView, cityName: cityName,region_radious: region_radious)

    }
    

    
    
}
