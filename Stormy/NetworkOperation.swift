//
//  NetworkOperation.swift
//  Stormy
//
//  Created by Angel Caro on 3/30/16.
//  Copyright © 2016 AngelCaro. All rights reserved.
//

import Foundation

class NetworkOperation {
    
    lazy var config: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session: NSURLSession = NSURLSession(configuration: self.config)
    let queryURL: NSURL
    
    typealias JSONDictionaryCompletion = ([String: AnyObject]?) -> Void
    
    init(url: NSURL) {
        self.queryURL = url
    }
    
    func downloadJSONFromURL(completion: JSONDictionaryCompletion) {
        
        let request: NSURLRequest = NSURLRequest(URL: queryURL)
        let dataTask = session.dataTaskWithRequest(request) {( let data, let response, let error) in
        //1.Check http response
            
            if let httpResponse = response as? NSHTTPURLResponse {
                do {
                    let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [String: AnyObject]
                    completion(jsonDictionary)
                } catch let error {
                    print("JSON Serialization failed. Error: \(error)")
                }
            
        
            
        }
    }
    
    dataTask.resume()
    
    }
}