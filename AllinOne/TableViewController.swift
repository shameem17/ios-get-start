//
//  TableViewController.swift
//  AllinOne
//
//  Created by flash on 10/10/23.
//  Copyright © 2023 flash. All rights reserved.
//

import UIKit
import Foundation



class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    //    var country = Array<String>()
    
    
    
    var country = [Country]()
    
    func  getData(){
        
        let url = URL(string: "https://restcountries.com/v3.1/all")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do{
                
                if(error == nil)
                {
                    self.country = try JSONDecoder().decode([Country].self, from: data!)
                    
                    self.country.sort { (lhs: Country, rhs: Country) -> Bool in
                        // you can have additional code here
                        return lhs.name.common < rhs.name.common
                    }
                    for _ in self.country{
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                    //                    print(self.country.name)
                    //
                }
                
            }
            catch{
                print("Error in json data \(error)")
            }
            
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
        getData()
        tableView.dataSource = self
        tableView.delegate = self
        //        country = ["Bangladesh", "India", "USA", "UK"]
        
    }
    
    
    
}

extension TableViewController : UITableViewDelegate{
    
}

extension TableViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.country.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.country[indexPath.row].name.common
        cell.textLabel?.textAlignment = .center
        //        cell.capital.text = self.country[indexPath.row].name.official
        //        cell.capital.textAlignment = .center
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "weather") as! WatherViewController
        vc.country = self.country[indexPath.row].name.common
        vc.countryCode = self.country[indexPath.row].cca2
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

