//
//  ForecastService.swift
//  Stormy
//
//  Created by Angel Caro on 3/31/16.
//  Copyright © 2016 AngelCaro. All rights reserved.
//

import Foundation

struct ForecastService {
    
    let forecastAPIKey: String
    let forecastBaseURL: NSURL?
    
    init(APIKey: String) {
        
        self.forecastAPIKey = APIKey
        forecastBaseURL = NSURL(string: "https://api.forecast.io/forecast/\(forecastAPIKey)/")
        
    }
    
    func getForecast(lat: Double, lon: Double, completion: CurrentWeather? -> Void) {
        
        if let forecastURL = NSURL(string: "\(lat),\(lon)", relativeToURL: forecastBaseURL) {
            
            let networkOperation = NetworkOperation(url: forecastURL)
            networkOperation.downloadJSONFromURL {
                (let JSONDictionary) in
                
                let currentWeather = self.currentWeatherFromJSONDictionary(JSONDictionary)
                completion(currentWeather)
            }
            
        } else {
            
            print("Could not construct URL")
            
        }
        
    }
    
    func currentWeatherFromJSONDictionary(jsonDictionary: [String: AnyObject]?) -> CurrentWeather? {
        
        if let currentWeatherDictionary = jsonDictionary?["currently"] as? [String: AnyObject] {
            return CurrentWeather(weatherDictionary: currentWeatherDictionary)
        
        
        } else {
            print("JSON dictionary eturned nil for key currently")
            return nil
        }
    
    }
}