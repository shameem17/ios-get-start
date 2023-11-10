//
//  SearchViewController.swift
//  AllinOne
//
//  Created by flash on 10/25/23.
//  Copyright © 2023 flash. All rights reserved.
//

import UIKit
import DropDown

class SearchViewController: UIViewController {
    @IBOutlet weak var myDropDownView: UIView!
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var countryLbl: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var myDropDown = DropDown()
    var countries = [Country]()
    var city = [City]()
    var countryList = [String]()
    var code = [String]()
    var name: String = ""
    var countrCode = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries = CommonData.shared.country
        tableView.delegate = self as UITableViewDelegate
        tableView.dataSource = self as UITableViewDataSource
        // Do any additional setup after loading the view.
        
        
        //        countryList.append("BGd")
        
        
        myDropDown.anchorView = myDropDownView
        
        
        myDropDown.bottomOffset = CGPoint(x:0, y:(myDropDown.anchorView?.plainView.bounds.height)!)
        
        myDropDown.topOffset = CGPoint(x:0, y:-(myDropDown.anchorView?.plainView.bounds.height)!)
        
        myDropDown.direction = .bottom
        
        myDropDown.selectionAction = {  (index: Int, item: String) in
            self.searchText.text = self.countryList[index]
            self.countryLbl.text = self.countryList[index]
            //            self.countrCode = self.code[index]
            //            self.countryCode = self.code[index]
            //            self.countryLabel.textColor = .black
        }
        //        myDropDown.show()
        
        searchText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        // Handle text changes here
        
        countryLbl.text = ""
        countryList = [String]()
        if var text = searchText.text {
            //            print("Text changed to: \(text)")
            //            var text = searchText.text!
            text = text.lowercased()
            for x in countries{
                var temp = x.name.common as String
                temp = temp.lowercased()
                
                if((temp.range(of: text)) != nil)
                {
                    countryList.append(x.name.common)
                }
            }
            myDropDown.dataSource = countryList
            myDropDown.show()
            
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
    
    
    @IBAction func gobtn(_ sender: Any) {
        var text = self.countryLbl.text!
        text = text.lowercased()
        
        if let fooOffset = countries.firstIndex(where: {$0.name.common.lowercased() == text}) {
            // do something with fooOffset
            name = countries[fooOffset].name.common
            countrCode = countries[fooOffset].cca2
            
            print(name,":",countrCode)
            let indicatorView = activityIndicator(style: .large,
                                                  center: self.view.center)
            
            indicatorView.stopAnimating()
            
            self.view.addSubview(indicatorView)
            indicatorView.startAnimating()
            indicatorView.hidesWhenStopped = true
            
            
            let apiKey = "eYvZel2XqS95RH0oo6Siotxik7G9YSGf"
            
            let baseURLString = "https://api.apilayer.com/geo/country/cities/"+countrCode
            
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
                            vc.country = self.name
                            vc.countryCode = self.countrCode
                            vc.city = self.city
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                    
                }
                catch{
                    DispatchQueue.main.async {
                        indicatorView.stopAnimating()
                        self.showToast(message: "Something Went Wrong", font: .systemFont(ofSize: 18.0))
                    }
                    print("Error in json data \(error)")
                    //                return []
                }
                
            }.resume()
            
        } else {
            // item could not be found
            self.showToast(message: "Please Select a Valid Country", font: .systemFont(ofSize: 18.0))
        }
        
        
        
    }
    
    
}

extension SearchViewController : UITableViewDelegate{
    
}

extension SearchViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        cell.countryName.text = self.countries[indexPath.row].name.common
        //        cell.textLabel?.textAlignment = .center
        //        cell.capital.text = self.country[indexPath.row].name.official
        //        cell.capital.textAlignment = .center
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.searchText.text = self.countries[indexPath.row].name.common
        
        self.countryLbl.text = self.countries[indexPath.row].name.common
        
        
    }
    
    
}




