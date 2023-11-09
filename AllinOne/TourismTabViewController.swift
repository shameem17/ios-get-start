//
//  TourismTabViewController.swift
//  AllinOne
//
//  Created by flash on 10/27/23.
//  Copyright © 2023 flash. All rights reserved.
//

import UIKit

// MARK: - colonable structure

struct CityDetails: Codable {
    var data: [CityData]
}

struct CityData: Codable {
    var name: String
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case description = "description"
        
    }
    
}

struct Activity: Codable {
    var data: [ActivityDetails]
}

struct ActivityDetails: Codable {
    
//    var name: String
//    var description: String
    //    var geoCode: GeoCode
    //    var price: Price
    //    var pictures: [String]
    var bookingLink: String
    var minimumDuration: String
}



struct GeoCode: Codable {
    var latitude: Double
    var longitude: Double
}

struct Price: Codable {
    var amount: String
    var currencyCode: String
}

extension Activity {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        //        try container.encode(state_or_region, forKey: .state_or_region)
        //        try container.encode(latitude, forKey: .latitude)
        //        try container.encode(longitude, forKey: .longitude)
    }
}
struct Tes: Codable {
    var meta: Meta
}
struct Meta: Codable {
    var count: Int
}

extension ActivityDetails{
    func encode(to encoder: Encoder) throws{
        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(name, forKey: .name)
//        try container.encode(description, forKey: .description)
        try container.encode(bookingLink, forKey: .bookingLink)
        try container.encode(minimumDuration, forKey: .minimumDuration)
        
    }
}

class TourismTabViewController: UIViewController {
    
    var activity = [Activity]()
    // MARK: - functions
    

    
    func function()
    {
        
        
        // Define your endpoint and authorization token
        let urlString = "https://test.api.amadeus.com/v1/shopping/activities?latitude=41.397158&longitude=2.160873&radius=1"
        let accessToken = "ECg7f6rIQw3zCCcW9mKcJrhLo4r8"

        // Create the URL
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/vnd.amadeus+json", forHTTPHeaderField: "accept")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        // Create a URLSession data task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            
            
            do{
//                print(response)
          let decoder = JSONDecoder()
                //                let activities = try decoder.decode(Activity.self, from: data)
                //decoder.keyDecodingStrategy = .convertFromSnakeCase
                let activity = try decoder.decode(Activity.self, from: data)
                print(activity)
            } catch {
                print("Error decoding JSON: \(error)")
            }
            
            
            
            
            
        }

        // Start the data task
        task.resume()

        
    }
    
    
    func getSopt()
    {
        
        let client_id = "ztG1Ljcurz8honp4qcytKrFXF4ElX1Ng"
        let client_secret = "aiUyJS1tSBiomFNR"
        
        let suffix:String = String (CommonData.shared.lat) + "&longitude=" + String (CommonData.shared.long) + "&radius=5"
        
        let baseURLString = "https://test.api.amadeus.com/v1/shopping/activities?latitude=" + suffix
        
        let url = URL(string: baseURLString)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.addValue("Bearer \(client_id)", forHTTPHeaderField: "client_id")
        request.addValue(client_secret, forHTTPHeaderField: "client_secret")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Remaining code for data parsing and error handling remains the same as the previous example
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
             
//                print(data.description)
                let decoder = JSONDecoder()
                //                let activities = try decoder.decode(Activity.self, from: data)
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let activity = try? decoder.decode(Tes.self, from: data) {
                    //                    print("Activity Name: \(activity.name)")
                    //                    print("Description: \(activity.description)")
                    //                    print("Price: \(activity.price.amount) \(activity.price.currencyCode)")
                    // Access other properties as needed
                    print(activity)
                } else {
                    let activities = try decoder.decode(CityDetails.self, from: data)
                    print(activities)
                    //                    for activity in activities.data {
                    //                        print("Activity Name: \(activity.name)")
                    //                        print("Description: \(activity.description)")
                    //                        print("Price: \(activity.price.amount) \(activity.price.currencyCode)")
                    //                        // Access other properties as needed
                    //                    }
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        task.resume()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //getSopt()
        function()
        print(activity)
        
    }
    
}
