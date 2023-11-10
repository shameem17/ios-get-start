//
//  WatherViewController.swift
//  AllinOne
//
//  Created by flash on 10/18/23.
//  Copyright © 2023 flash. All rights reserved.
//

import UIKit
import Foundation
import NotificationCenter
import DropDown


class WatherViewController: UIViewController {
    var country = ""
    var showCountry = ""
    var weather: Weather!
    var countryCode = ""

    var city = [City]()
    var myDropDown = DropDown()
    var cityList = [String]()
    var longitude: Double = 0.0
    var latitude: Double = 0.0
    var cityName: String = ""
    
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var conditionLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var myDropDownView: UIView!
    
    
    func demo2(){
        
        let url = URL(string: "https://api.countrystatecity.in/v1/countries/in/cities")!
        // Create the URLRequest
        var request = URLRequest(url: url)
        
        // Set the request method to GET
        request.httpMethod = "GET"
        
        // Set the headers
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("UXRxWnRUZHE2eWtLbTliNVlpM3YxbFJxUVZZdXB4UTJ2bnZXNGs2cA==", forHTTPHeaderField: "X-CSCAPI-KEY")
        
        // Create a URLSession task to send the request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                // Process the response data here
                if let jsonString = String(data: data, encoding: .utf8) {
                    //Parse and work with the JSON data as needed
                    print(jsonString)
                }
            }
        }
        
        // Start the task
        task.resume()
        
    }
    func getCity(countryCode: String)
    {
        
        let apiKey = "eYvZel2XqS95RH0oo6Siotxik7G9YSGf"
        
        let baseURLString = "https://api.apilayer.com/geo/country/cities/"+countryCode
        
        var urlComponents = URLComponents(string: baseURLString)
        
        let queryItems = [URLQueryItem(name: "apikey", value: apiKey)]
        
        urlComponents?.queryItems = queryItems
        let url1 = urlComponents?.url
        
        let data = NSData(contentsOf: url1! as URL)
        if(data != nil){
            
            var tmpValues = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
            tmpValues = tmpValues.reversed() as NSArray
            city = try! JSONDecoder().decode([City].self, from: data! as Data)
            
        }
        else{
            DispatchQueue.main.async {
                //                                   indicatorView.stopAnimating()
                self.showToast(message: "Something Went Wrong", font: .systemFont(ofSize: 18.0))
            }
            print("Error Parsing City Data")
        }
        
    }
    
    func  getWeather(country: String){
        
        let indicatorView = activityIndicator(style: .large,
                                              center: self.view.center)
        
        self.view.addSubview(indicatorView)
        indicatorView.startAnimating()
        
        label.isHidden = true
        countryLbl.isHidden = true
        conditionLbl.isHidden = true
        timeLbl.isHidden = true
        
        
        let str = "https://api.weatherapi.com/v1/current.json?key=1f1c2b7ed5d74ad3ae160133231910&q="+country+"&aqi=no"
        //        print(str)
        let url = URL(string: str)
        //        print(url!)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do{
                
                if(error == nil)
                {
                    self.weather = try JSONDecoder().decode(Weather.self, from: data!)
                    
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
                    
                    DispatchQueue.main.async {
                        
                        indicatorView.stopAnimating()
                        let st = String (self.weather.current.temp_c)
                        self.label.text = st
                        self.countryLbl.text = self.showCountry
                        self.conditionLbl.text = String (self.weather.current.condition.text)
                        self.timeLbl.text = time
                        
                        self.label.isHidden = false
                        self.countryLbl.isHidden = false
                        self.conditionLbl.isHidden = false
                        self.timeLbl.isHidden = false
                        
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
    
    
    func  getWeatherBy(longitdue: Double, latitude: Double, vc: CityDetailsViewController){
        
        let indicatorView = activityIndicator(style: .large,
                                              center: self.view.center)
        
        self.view.addSubview(indicatorView)
        indicatorView.startAnimating()
        
        
        let temp = String (latitude) + "," + String (longitude)
        
        let str = "https://api.weatherapi.com/v1/current.json?key=1f1c2b7ed5d74ad3ae160133231910&q="+temp+"&aqi=no"
        //        print(str)
        let url = URL(string: str)
        //        print(url!)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do{
                
                if(error == nil)
                {
                    self.weather = try JSONDecoder().decode(Weather.self, from: data!)
                    
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
                    print(hh,":",mm)
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
                        
                        vc.cityNameLbl.isHidden = false
                        vc.tempLbl.isHidden = false
                        vc.conditionLbl.isHidden = false
                        vc.conditionImg.isHidden = false
                        vc.timeLbl.isHidden = false
                        vc.dateLbl.isHidden = false
                        
                        let st = String (self.weather.current.temp_c)
                        vc.tempLbl.text = st + " \u{00B0}C"
                        vc.conditionLbl.text = String (self.weather.current.condition.text)
                        vc.loadImge(str: self.weather.current.condition.icon)
                        vc.timeLbl.text = time
                        vc.dateLbl.text = date
                        if(self.weather.current.is_day == 0){
                            vc.view.backgroundColor = UIColor(hexString: "212124")
                            vc.tempLbl.textColor = .white
                            vc.conditionLbl.textColor = .white
                            vc.cityNameLbl.textColor = .white
                            vc.timeLbl.textColor = .white
                            vc.dateLbl.textColor = .white
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
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showCountry = country
        country = formate(str: country)
        getWeather(country: country)
        
        myDropDown.anchorView = myDropDownView
        
        
        myDropDown.bottomOffset = CGPoint(x:0, y:(myDropDown.anchorView?.plainView.bounds.height)!)
        
        myDropDown.topOffset = CGPoint(x:0, y:-(myDropDown.anchorView?.plainView.bounds.height)!)
        
        myDropDown.direction = .bottom
        
        myDropDown.selectionAction = {  (index: Int, item: String) in
            self.searchText.text = self.cityList[index]
            //            self.countryLbl.text = self.cityList[index]
            
        }
        
        searchText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        
        
        
        
        tableView.dataSource = self as UITableViewDataSource
        tableView.delegate = self as UITableViewDelegate
        
        
    }
    // MARK: - url= https://api.weatherapi.com/v1/current.json?key=1f1c2b7ed5d74ad3ae160133231910&q=Bangladesh&aqi=no
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        // Handle text changes here
        //        countryLbl.text = ""
        cityList = [String]()
        if var text = searchText.text {
            //            print("Text changed to: \(text)")
            //            var text = searchText.text!
            text = text.lowercased()
            for x in city{
                var temp = x.name as String
                temp = temp.lowercased()
                
                if((temp.range(of: text)) != nil)
                {
                    cityList.append(x.name)
                }
            }
            myDropDown.dataSource = cityList
            myDropDown.show()
        }
        
    }
    
    func tabView()
    {
        var text = self.searchText.text!
        text = text.lowercased()
        //        print(text)
        var flag = false
        for x in city{
            var temp = x.name
            temp = temp.lowercased()
            if(temp == text)
            {
                CommonData.shared.cityName = x.name
                CommonData.shared.lat = x.latitude
                CommonData.shared.long = x.longitude
                flag = true
                break
            }
            
        }
        if(flag)
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "tabBar") as! TabBarController
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else
        {
            self.showToast(message: "Please Select a Valid City", font: .systemFont(ofSize: 18.0))
        }
    }
    
    
    
    @IBAction func go(_ sender: Any) {
        tabView()

    }
    
    
    
    
    
    func formate(str: String) -> String {
        var tem = ""
        for x in str{
            if((x>="A"&&x<="Z")||(x>="a"&&x<="z"))
            {
                tem.append(x)
            }
            else if(x==" "){
                tem.append("%20")
            }
        }
        return tem
    }
    @objc func didgetNotification(_ notification: Notification){
        print("Also Here")
        let text = notification.object as! String?
        print(text!)
        label.text = text
    }
    
    
    
    
}

extension WatherViewController: UITableViewDelegate{
    
}

extension WatherViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.city.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        cell.cityLbl.text = city[indexPath.row].name
        cell.cityLbl.textAlignment = .left
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Seletcted \(city[indexPath.row].name) longitude= \(self.city[indexPath.row].longitude)")
        CommonData.shared.cityName = city[indexPath.row].name
        CommonData.shared.lat = city[indexPath.row].latitude
        CommonData.shared.long = city[indexPath.row].longitude
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "tabBar") as! TabBarController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}



//
