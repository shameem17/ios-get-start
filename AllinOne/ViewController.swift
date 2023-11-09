//
//  ViewController.swift
//  AllinOne
//
//  Created by flash on 10/10/23.
//  Copyright © 2023 flash. All rights reserved.
//

import UIKit
import CoreLocation



class ViewController: UIViewController {
    
    var locationManager = CLLocationManager()
    var country = [Country]()
    var temp: [AnyObject] = []
    var city = [City]()
    var isCalled: Bool = false
    
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
    
    
    
    func  getData(){
        print("getData Called")
        isCalled = true
        let indicatorView = activityIndicator(style: .large,
                                              center: self.view.center)
        
        indicatorView.stopAnimating()
        
        self.view.addSubview(indicatorView)
        indicatorView.startAnimating()
        indicatorView.hidesWhenStopped = true
        
        let url = URL(string: "https://restcountries.com/v3.1/all")
        
        URLSession.shared.dataTask(with: url!){ (data, response, error) in
            do{
                
                if(error == nil)
                {
                    self.country = try JSONDecoder().decode([Country].self, from: data!)
                    
                    DispatchQueue.main.async {
                        print("common data loaded")
                        CommonData.shared.country = self.country
                        indicatorView.stopAnimating()
                    }
                    
                }
                
            }
            catch{
                self.showToast(message: "Error is Parsing Json Data", font: .systemFont(ofSize: 18.0))
                DispatchQueue.main.async {
                    indicatorView.stopAnimating()
                }
                print("Error in json data \(error)")
                //                return []
            }
            
        }.resume()
        
        
    }
    
    
    @IBAction func DropDown(_ sender: Any) {
        if(isCalled == false)
        {
            isCalled = true
            let indicatorView = activityIndicator(style: .large,
                                                  center: self.view.center)
            
            indicatorView.stopAnimating()
            
            self.view.addSubview(indicatorView)
            indicatorView.startAnimating()
            indicatorView.hidesWhenStopped = true
            
            let url = URL(string: "https://restcountries.com/v3.1/all")
            
            URLSession.shared.dataTask(with: url!){ (data, response, error) in
                do{
                    
                    if(error == nil)
                    {
                        self.country = try JSONDecoder().decode([Country].self, from: data!)
                        
                        DispatchQueue.main.async {
                            
                            CommonData.shared.country = self.country
                            
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            let vc = storyBoard.instantiateViewController(withIdentifier: "DropDown") as! DropDownViewController
                            //                                          vc.countries = self.country
                            self.navigationController?.pushViewController(vc, animated: true)
                            indicatorView.stopAnimating()
                        }
                        
                    }
                    
                }
                catch{
                    self.showToast(message: "Error is Parsing Json Data", font: .systemFont(ofSize: 18.0))
                    DispatchQueue.main.async {
                        indicatorView.stopAnimating()
                    }
                    print("Error in json data \(error)")
                    //                return []
                }
                
            }.resume()
            
            
        }
        else
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "DropDown") as! DropDownViewController
            //                                          vc.countries = self.country
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
     // MARK:-  Search
    
    @IBAction func search(_ sender: Any) {
        
       
        
        if(isCalled == false)
        {
            isCalled = true
            let indicatorView = activityIndicator(style: .large,
                                                  center: self.view.center)
            
            indicatorView.stopAnimating()
            
            self.view.addSubview(indicatorView)
            indicatorView.startAnimating()
            indicatorView.hidesWhenStopped = true
            
            let url = URL(string: "https://restcountries.com/v3.1/all")
            
            URLSession.shared.dataTask(with: url!){ (data, response, error) in
                do{
                    
                    if(error == nil)
                    {
                        self.country = try JSONDecoder().decode([Country].self, from: data!)
                        
                        DispatchQueue.main.async {
                            
                            CommonData.shared.country = self.country
                            
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            let vc = storyBoard.instantiateViewController(withIdentifier: "search") as! SearchViewController
                            //                                          vc.countries = self.country
                            self.navigationController?.pushViewController(vc, animated: true)
                            indicatorView.stopAnimating()
                        }
                        
                    }
                    
                }
                catch{
                    self.showToast(message: "Error is Parsing Json Data", font: .systemFont(ofSize: 18.0))
                    DispatchQueue.main.async {
                        indicatorView.stopAnimating()
                    }
                    print("Error in json data \(error)")
                    //                return []
                }
                
            }.resume()
            
            
        }
        else
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "search") as! SearchViewController
            //                                          vc.countries = self.country
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
  
  
        
    }
    
    @IBAction func calculatorTapped(_ sender: Any) {
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "calculator") as! CalculatorViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
   
    // MARK: - Effective Json Parsing
    func newJson() {
        
        let indicatorView = activityIndicator(style: .large,
                                              center: self.view.center)
        
        indicatorView.stopAnimating()
        
        self.view.addSubview(indicatorView)
        indicatorView.startAnimating()
        indicatorView.hidesWhenStopped = true
        
        
        let url = NSURL(string: "https://restcountries.com/v3.1/all")
        let data = NSData(contentsOf: url! as URL)
        if(data != nil)
        {
            var temp = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
            temp = temp.reversed() as NSArray
            country = try! JSONDecoder().decode([Country].self, from: data! as Data)
            indicatorView.stopAnimating()
        }
        else
        {
            showToast(message: "Error in API call", font: .systemFont(ofSize: 18.3))
        }
        
    }
    
    
    
    @IBAction func table(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "TableView") as! TableViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    @IBAction func web(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let webViewController = storyBoard.instantiateViewController(withIdentifier: "WebView") as! WebViewController
        
        self.navigationController?.pushViewController(webViewController, animated: true)
        
        
    }
    @IBAction func collection(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let collectionViewController = storyBoard.instantiateViewController(withIdentifier: "CollectionView") as! CollectionViewController
        self.navigationController?.pushViewController(collectionViewController, animated: true)
        
        
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func image(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let imageViewController = storyBoard.instantiateViewController(withIdentifier: "imageView") as! ImageViewController
        self.navigationController?.pushViewController(imageViewController, animated: true)
        
    
    }
    @IBAction func map(_ sender: Any) {
        let mapStoryBoard:UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
        let vc = mapStoryBoard.instantiateViewController(identifier: "MapView") as! MapViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        getCurrentLocation()
    }
    
    func getCurrentLocation() {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        //lblLocation.text = "latitude = \(locValue.latitude), longitude = \(locValue.longitude)"
        CommonData.shared.lat = locValue.latitude
        CommonData.shared.long = locValue.longitude
        
    }
}

