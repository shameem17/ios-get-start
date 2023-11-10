//
//  Functions.swift
//  AllinOne
//
//  Created by flash on 11/10/23.
//  Copyright © 2023 flash. All rights reserved.
//
import UIKit
import Foundation
import MapKit
var country = [Country]()


public func activityIndicator(style: UIActivityIndicatorView.Style = .medium,
                              frame: CGRect? = nil,
                              center: CGPoint? = nil) -> UIActivityIndicatorView {
    
    // 2
    let activityIndicatorView = UIActivityIndicatorView(style: style)
    
    // 3
    if let frame = frame {
        activityIndicatorView.frame = frame
    }
    
    // 4
    if let center = center {
        activityIndicatorView.center = center
    }
    
    // 5
    return activityIndicatorView
}


func newJson() {
    let url = NSURL(string: "https://restcountries.com/v3.1/all")
    
    let data = NSData(contentsOf: url! as URL)
    var tmpValues = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
    tmpValues = tmpValues.reversed() as NSArray
    //             reloadInputViews()
    country = try! JSONDecoder().decode([Country].self, from: data! as Data)
}

func centreMap(latitude: CLLocationDegrees, longitude: CLLocationDegrees, mapView: MKMapView, cityName: String, region_radious: Int){
    let location = CLLocation(latitude: latitude, longitude: longitude)
    let region = MKCoordinateRegion(center: location.coordinate,latitudinalMeters: CLLocationDistance(region_radious), longitudinalMeters: CLLocationDistance(region_radious))
    mapView.setRegion(region, animated: true)
    let loc: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
    let annotation: MKPointAnnotation = MKPointAnnotation()
    annotation.coordinate = loc
    annotation.title = cityName
    //        annotation.subtitle = "Capital of Bangladesh"
    mapView.addAnnotation(annotation)
   // return mapView
}


func formater( name: String)-> String{
    var temp = name
    temp = temp.replacingOccurrences(of: "ā", with: "a")
    temp = temp.replacingOccurrences(of: "ī", with: "i")
    temp = temp.replacingOccurrences(of: "ū", with: "u")
    temp = temp.replacingOccurrences(of: "Ā", with: "A")
    
    temp = temp.replacingOccurrences(of: "Č", with: "C")
    temp = temp.replacingOccurrences(of: "č", with: "c")
    temp = temp.replacingOccurrences(of: "Ē", with: "E")
    temp = temp.replacingOccurrences(of: "Ģ", with: "G")
    temp = temp.replacingOccurrences(of: "ģ", with: "g")
    temp = temp.replacingOccurrences(of: "Ķ", with: "k")
    temp = temp.replacingOccurrences(of: "ē", with: "e")
    temp = temp.replacingOccurrences(of: "ķ", with: "k")
    
    temp = temp.replacingOccurrences(of: "Ņ", with: "N")
    temp = temp.replacingOccurrences(of: "ņ", with: "n")
    temp = temp.replacingOccurrences(of: "Š", with: "S")
    temp = temp.replacingOccurrences(of: "š", with: "s")
    temp = temp.replacingOccurrences(of: "Ž", with: "Z")
    temp = temp.replacingOccurrences(of: "ž", with: "z")
    
    
    return temp
}
