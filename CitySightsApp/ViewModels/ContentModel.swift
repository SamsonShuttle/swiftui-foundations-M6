//
//  ContentModel.swift
//  CitySightsApp
//
//  Created by Samson Shuttle on 07/03/2022.
//

import Foundation
import CoreLocation // To gte user location

class ContentModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    var locationManager = CLLocationManager()
    
    @Published var authorizationState = CLAuthorizationStatus.notDetermined
    
    @Published var restraurants = [Business]()
    @Published var sights = [Business]()
    
    
    // Run when ContentModel is run
    override init() {
        
        // Init method of NSObject
        super.init()
        
        // Set content model as the delegate to the location manager
        locationManager.delegate = self
        
        
    }
    
    func requestGeolocationPermission() {
        // Request permission for the user
        locationManager.requestWhenInUseAuthorization()
    }
    
    
    // MARK: - Location manager delegate methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // update the authorizationState property
        self.authorizationState = locationManager.authorizationStatus
        
        if locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse {
            
            // We have permission
            // TODO: Start geolocating the user, after we get permisson
            locationManager.startUpdatingLocation()
            
        }
        else if  locationManager.authorizationStatus == .denied {
            
            // We dont have permission
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Gives us the location of user
        let userLocation = locations.first
        
        if userLocation != nil {
            
            // We have Location
            // Stop requesting the location after we get it once
            locationManager.startUpdatingLocation()
            
            // If we have the coordinates of the user, send into Yelp API
            getBusinesses(category: Constants.sightsKey, location: userLocation!)
            getBusinesses(category: Constants.restaurantsKey, location: userLocation!)
            
        }
    }
    
    // MARK: - Yelp API methods
    
    func getBusinesses(category:String, location:CLLocation) {
        
        // Create URL
        /*
        let urlString = ""
        let url URL("https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&categories=\(category)&limit=6")
        let url = URL(string: urlString)
         */
        var urlComponents = URLComponents(string: Constants.apiURL)
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "6")
        ]
        let url = urlComponents?.url
        
        if let url = url {
            
            // Create URL Request
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
            request.httpMethod = "GET"
            request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
            
            // Get URLSession
            let session = URLSession.shared
            
            // Create Data Task
            let dataTask = session.dataTask(with: request) { data, response, error in
                
                // Check that there inst an error
                if error == nil {
                    
                    // Parse json
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(BusinessSearch.self, from: data!)
                        
                        // SOrt Businesser
                        var businesses = result.businesses
                        businesses.sort { (b1, b2) -> Bool in
                            return b1.distance ?? 0 < b2.distance ?? 0
                        }
                        
                        // Call get image function of the businesses
                        for b in businesses {
                            b.getImageData()
                        }
                        
                        DispatchQueue.main.async {
                            // Assign results to the appropriate property
                            switch category {
                            case Constants.sightsKey: self.sights = businesses
                            case Constants.restaurantsKey: self.restraurants = businesses
                            default: break
                            }
                            
                        }
                 
                        
                    }
                    catch {
                        print(error)
                    }
                    
                }
                
            }
            
            // Start the Data Task
            dataTask.resume()
            
        }
        
    }
    
}
