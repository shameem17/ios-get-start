//
//  DropDownViewController.swift
//  AllinOne
//
//  Created by flash on 10/18/23.
//  Copyright © 2023 flash. All rights reserved.
//

import UIKit
import DropDown
import NotificationCenter


class DropDownViewController: UIViewController {
    
    
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var myDropDownView: UIView!
    @IBOutlet weak var dropDownButton: UIButton!
    
    
    
    
    let myDropDown = DropDown()
    var city = [City]()
    var countryValue = [String]()
    var code = [String]()
    var countries = [Country]()
    var countryCode = ""
    
    func newJson() {
        let url = NSURL(string: "https://restcountries.com/v3.1/all")
        
        let data = NSData(contentsOf: url! as URL)
        var tmpValues = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
        tmpValues = tmpValues.reversed() as NSArray
        //             reloadInputViews()
        countries = try! JSONDecoder().decode([Country].self, from: data! as Data)
    }
    
    @IBAction func isTappedDropDownButton(_ sender: Any) {
        myDropDown.show()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        newJson()
        countries = CommonData.shared.country
        self.countries.sort { (lhs: Country, rhs: Country) -> Bool in
            // you can have additional code here
            return lhs.name.common < rhs.name.common
        }
        for x in countries{
            //            print(x.name.common)
            countryValue.append(x.name.common )
            code.append(x.cca2)
        }
        
        myDropDown.anchorView = myDropDownView
        myDropDown.dataSource = countryValue
        
        myDropDown.bottomOffset = CGPoint(x:0, y:(myDropDown.anchorView?.plainView.bounds.height)!)
        
        myDropDown.topOffset = CGPoint(x:0, y:-(myDropDown.anchorView?.plainView.bounds.height)!)
        
        myDropDown.direction = .bottom
        
        myDropDown.selectionAction = {  (index: Int, item: String) in
            self.countryLabel.text = self.countryValue[index]
            self.countryCode = self.code[index]
            self.countryLabel.textColor = .black
            
            
            
        }
        //         show()
        
        
    }
    func show()
    {
        print("The countries are: ")
        for x in countries{
            print(x.name.common)
        }
    }
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
    
    
    @IBAction func goBtn(_ sender: Any) {
        
        
        
        let indicatorView = activityIndicator(style: .large,
                                              center: self.view.center)
        
        self.view.addSubview(indicatorView)
        indicatorView.startAnimating()
        indicatorView.hidesWhenStopped = true
        
        let text = self.countryLabel.text!
        
        if(text != "Select Country")
        {
            
            let apiKey = "eYvZel2XqS95RH0oo6Siotxik7G9YSGf"
            
            let baseURLString = "https://api.apilayer.com/geo/country/cities/"+self.countryCode
            
            var urlComponents = URLComponents(string: baseURLString)
            
            let queryItems = [URLQueryItem(name: "apikey", value: apiKey)]
            
            urlComponents?.queryItems = queryItems
            let url1 = urlComponents?.url
            
            URLSession.shared.dataTask(with: url1!){ (data, response, error) in
                do{
                    
                    if(error == nil)
                    {
                        self.city = try JSONDecoder().decode([City].self, from: data!)
                        
                        DispatchQueue.main.async {
                            indicatorView.stopAnimating()
                            let vc = self.storyboard?.instantiateViewController(identifier: "weather") as! WatherViewController
                            vc.country = self.countryLabel.text!
                            vc.countryCode = self.countryCode
                            vc.city = self.city
                            
                            
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        
                        
                        //
                        
                    }
                    else
                    {
                        DispatchQueue.main.async {
                            indicatorView.stopAnimating()
                            self.showToast(message: "Something Went Wrong", font: .systemFont(ofSize: 18.0))
                        }
                    }
                    
                }
                catch{
                    DispatchQueue.main.async {
                        indicatorView.stopAnimating()
                        self.showToast(message: "Something Went Wrong", font: .systemFont(ofSize: 18.0))
                    }
                    //                    indicatorView.stopAnimating()
                    print("Error in json data \(error)")
                    //                      self.showToast(message: "Something Went Wrong", font: .systemFont(ofSize: 18.0))
                    
                    //                return []
                }
                
            }.resume()
            
        }
        else{
            indicatorView.stopAnimating()
            self.showToast(message: "Please Select A Country", font: .systemFont(ofSize: 18.0))
        }
        
        
        
    }
    
}

extension UIViewController {
    
    func showToast(message : String, font: UIFont) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 125, y: self.view.frame.size.height-100, width: 250, height: 35))
        toastLabel.backgroundColor = UIColor.lightGray.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.red
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    } }
