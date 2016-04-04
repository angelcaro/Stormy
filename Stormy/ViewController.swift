//
//  ViewController.swift
//  Stormy
//
//  Created by Angel Caro on 3/30/16.
//  Copyright © 2016 AngelCaro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var currentTemperatureLabel: UILabel?
    @IBOutlet weak var currentHumidityLabel: UILabel?
    @IBOutlet weak var currentPrecipitationLabel: UILabel?
    @IBOutlet weak var currentWeatherIcon: UIImageView?
    @IBOutlet weak var currentWeatherSummary: UILabel?
    @IBOutlet weak var refreshButton: UIButton?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let forecastAPIKey = "37dd622a63016366ea62afa3b63a03d1"
    let coordinate: (lat:Double, lon:Double) = (37.8267,-122.423)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrieveWeatherForecast()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func retrieveWeatherForecast() {
        
        let forecastService = ForecastService(APIKey: forecastAPIKey)
        forecastService.getForecast(coordinate.lat, lon: coordinate.lon) {
            (let currently) in
            if let currentWeather = currently {
                //Update UI
                dispatch_async(dispatch_get_main_queue()) {
                    
                    if let temperature = currentWeather.temperature {
                        self.currentTemperatureLabel?.text = "\(temperature)º"
                    }
                    
                    if let humidity = currentWeather.humidity {
                        self.currentHumidityLabel?.text = "\(humidity)%"
                    }
                    
                    if let precipitation = currentWeather.precipProbability {
                        self.currentPrecipitationLabel?.text = "\(precipitation)%"
                    }
                    
                    if let icon = currentWeather.icon {
                        self.currentWeatherIcon?.image = icon
                    }
                    
                    if let summary = currentWeather.summary {
                        self.currentWeatherSummary?.text = summary
                    }
                    
                    self.toggleRefreshAnimation(false)
                }
            }
        }
        
    }
    
    
    @IBAction func refreshWeather() {
        
        toggleRefreshAnimation(true)
        retrieveWeatherForecast()
        
    }
    
    func toggleRefreshAnimation(on: Bool) {
        
        refreshButton?.hidden = on
        if on {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        
    }
    
    

}

