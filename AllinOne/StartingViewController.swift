//
//  StartingViewController.swift
//  AllinOne
//
//  Created by flash on 10/31/23.
//  Copyright © 2023 flash. All rights reserved.
//

import UIKit

class StartingViewController: UIViewController {
    var country = [Country]()
    func newJson() {
        let url = NSURL(string: "https://restcountries.com/v3.1/all")
        
        let data = NSData(contentsOf: url! as URL)
        var tmpValues = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
        tmpValues = tmpValues.reversed() as NSArray
        //             reloadInputViews()
        country = try! JSONDecoder().decode([Country].self, from: data! as Data)
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
    override func viewDidLoad() {
        super.viewDidLoad()
        newJson()
        let indicatorView = activityIndicator(style: .large,
                                              center: self.view.center)
        
        self.view.addSubview(indicatorView)
        indicatorView.startAnimating()
        indicatorView.hidesWhenStopped = true
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
