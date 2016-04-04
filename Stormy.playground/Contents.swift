//: Playground - noun: a place where people can play

import UIKit
import Foundation

let forecastAPIKey = "37dd622a63016366ea62afa3b63a03d1"

let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(forecastAPIKey)/")
let forecastURL = NSURL(string: "37.8267,-122.423", relativeToURL: baseURL)
