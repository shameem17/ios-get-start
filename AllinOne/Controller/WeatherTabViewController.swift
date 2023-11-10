//
//  WeatherTabViewController.swift
//  AllinOne
//
//  Created by flash on 10/27/23.
//  Copyright © 2023 flash. All rights reserved.
//

import UIKit
import Foundation


class WeatherTabViewController: UIViewController {
    
    var cityName: String = ""
    var latitude: Double = CommonData.shared.lat
    var longitude: Double = CommonData.shared.long
    @IBOutlet weak var cityNameLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var conditionLbl: UILabel!
    @IBOutlet weak var conditionImg: UIImageView!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    var weather: Weather!
    
    func loadImge(str: String){
        
        let temp = "https:"+str
        //        print(temp)
        if let imageURL = URL(string: temp) {
            if let imageData = try? Data(contentsOf: imageURL) {
                if let image = UIImage(data: imageData) {
                    
                    conditionImg.image = image
                }
            }
        }
    }
    func digit(x: Character)->Int{
        if(x=="0")
        {
            return 0;
        }
        if(x=="1")
        {
            return 1
        }
        if(x=="2")
        {
            return 2
        }
        if(x=="3")
        {
            return 3
        }
        if(x=="4")
        {
            return 4
        }
        if(x=="5")
        {
            return 5
        }
        if(x=="6")
        {
            return 6
        }
        if(x=="7")
        {
            return 7
        }
        if(x=="8")
        {
            return 8
        }
        return 9
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
    
    func  getWeather(latitude: Double, longitude: Double){
        
        let indicatorView = self.activityIndicator(style: .large,
                                                   center: self.view.center)
        
        self.view.addSubview(indicatorView)
        
        
        indicatorView.startAnimating()
        
        let temp = String (latitude) + "," + String (longitude)
        //        print(temp)
        let str = "https://api.weatherapi.com/v1/current.json?key=1f1c2b7ed5d74ad3ae160133231910&q="+temp+"&aqi=no"
        //        print(str)
        let url = URL(string: str)
        //        print(url!)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do{
                
                if(error == nil)
                {
                    self.weather = try JSONDecoder().decode(Weather.self, from: data!)
                    //                    print("The temp is:",self.weather.current.temp_c)
                    
                    let temp = self.weather.location.localtime
                    var time = ""
                    var date = ""
                    var flag = false
                    for x in temp{
                        if(x==" ")
                        {
                            flag = true
                        }
                        if(flag)
                        {
                            time.append(x)
                        }
                        else if(!flag)
                        {
                            date.append(x)
                        }
                    }
                    
                    var hh = 0
                    var mm = 0
                    flag = false
                    for x in time{
                        if(x == ":")
                        {
                            flag = true
                            continue
                        }
                        if(x>="0"&&x<="9")
                        {
                            if(!flag)
                            {
                                
                                hh = hh*10 + self.digit(x:x)
                            }
                            else
                            {
                                mm = mm*10 + self.digit(x: x)
                            }
                        }
                    }
                    //print(hh,":",mm)
                    if(hh <  12)
                    {
                        time.append(" AM")
                    }
                    else if(hh == 12)
                    {
                        time.append(" PM")
                    }
                    else
                    {
                        
                        hh = hh % 12
                        time = ""
                        if(hh<10)
                        {
                            //                            time = "0"
                        }
                        time.append(String(hh))
                        time.append(":")
                        if(mm<10)
                        {
                            time.append("0")
                        }
                        time.append(String(mm))
                        
                        time.append(" PM")
                        
                    }
                    
                    DispatchQueue.main.async {
                        indicatorView.stopAnimating()
                        self.cityNameLbl.isHidden = false
                        self.tempLbl.isHidden = false
                        self.conditionLbl.isHidden = false
                        self.conditionImg.isHidden = false
                        self.timeLbl.isHidden = false
                        self.dateLbl.isHidden = false
                        
                        let st = String (self.weather.current.temp_c)
                        self.cityNameLbl.text = self.weather.location.name
                        self.tempLbl.text = st + " \u{00B0}C"
                        self.conditionLbl.text = String (self.weather.current.condition.text)
                        self.loadImge(str: self.weather.current.condition.icon)
                        self.timeLbl.text = time
                        self.dateLbl.text = date
                        if(self.weather.current.is_day == 0){
                            self.view.backgroundColor = UIColor(hexString: "212124")
                            self.tempLbl.textColor = .white
                            self.conditionLbl.textColor = .white
                            self.cityNameLbl.textColor = .white
                            self.timeLbl.textColor = .white
                            self.dateLbl.textColor = .white
                        }
                        
                    }
                    
                }
                
            }
            catch{
                DispatchQueue.main.async {
                    indicatorView.stopAnimating()
                    self.showToast(message: "Something Went Wrong", font: .systemFont(ofSize: 18.0))
                }
                print("Error in json data \(error)")
            }
            
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityNameLbl.isHidden = true
        tempLbl.isHidden = true
        conditionLbl.isHidden = true
        conditionImg.isHidden = true
        timeLbl.isHidden = true
        dateLbl.isHidden = true
        
        cityNameLbl.text = cityName
        getWeather(latitude: latitude, longitude: longitude)
        
    }
    
    
    
}


