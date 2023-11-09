//
//  AppDelegate.swift
//  AllinOne
//
//  Created by flash on 10/10/23.
//  Copyright © 2023 flash. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var loged_in = false
    var country = [Country]()
    func newJson() {
        let url = NSURL(string: "https://restcountries.com/v3.1/all")
        
        let data = NSData(contentsOf: url! as URL)
        var tmpValues = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
        tmpValues = tmpValues.reversed() as NSArray
        //             reloadInputViews()
        country = try! JSONDecoder().decode([Country].self, from: data! as Data)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //      newJson()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    
    
}

