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
        centreMap(latitude: latitude, longitude: longitude)
        
    }
    
    
    func centreMap(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: location.coordinate,latitudinalMeters: CLLocationDistance(region_radious), longitudinalMeters: CLLocationDistance(region_radious))
        mapView.setRegion(region, animated: true)
        let loc: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let annotation: MKPointAnnotation = MKPointAnnotation()
        annotation.coordinate = loc
        annotation.title = cityName
        //        annotation.subtitle = "Capital of Bangladesh"
        self.mapView.addAnnotation(annotation)
    }
    
}
