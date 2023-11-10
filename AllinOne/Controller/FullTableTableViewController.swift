//
//  FullTableTableViewController.swift
//  AllinOne
//
//  Created by flash on 10/16/23.
//  Copyright © 2023 flash. All rights reserved.
//

import UIKit
import Foundation
struct Name: Decodable {
    let common:String
    let official: String
}
struct Country: Decodable {
    let cca2: String
    let name: Name
}

class FullTableTableViewController: UITableViewController {
    
    
    @IBOutlet var tab: UITableView!
    
    public var cities = Array<Any>()
    public var dist = Array<Any>()
    public var descp = Array<Any>()
    var commonOfficialArray: [(common: Any, official: Any)] = []
    
    var country=[Country]()
    
    func  getData(){
        
        let url = URL(string: "https://restcountries.com/v3.1/all")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do{
                if(error == nil)
                {
                    self.country = try JSONDecoder().decode([Country].self, from: data!)
                    
                    for _ in self.country{
                        DispatchQueue.main.async {
                            self.tab.reloadData()
                        }
                    }
                    
                }
                
            }
            catch{
                print("Error in json data \(error)")
            }
            
        }.resume()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        
    }
    
    // MARK: - New comment
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cities.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tabCell", for: indexPath)
        
        cell.textLabel?.text = self.country[indexPath.row].name.common
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
}
