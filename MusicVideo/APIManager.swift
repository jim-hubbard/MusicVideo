//
//  APIManager.swift
//  MusicVideo
//
//  Created by Jim Hubbard on 8/5/16.
//  Copyright © 2016 Jim Hubbard. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString:String, completion: [Video] -> Void ) {
        
        
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        
        
        //        let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlString)!
        
        let task = session.dataTaskWithURL(url) {
            (data, response, error) -> Void in
            
            if error != nil {
                print(error!.localizedDescription)
                
            } else {
                
                let videos = self.parseJason(data)
                
                
                
                let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                dispatch_async(dispatch_get_global_queue(priority, 0)) {
                    dispatch_async(dispatch_get_main_queue()) {
                        completion(videos)
                    }
                }
            }
            
        }
        task.resume()
    }
    
    func parseJason(data: NSData?) -> [Video] {
            
            do {
                
                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as AnyObject? {
                    
                    return JsonDataExtractor.extractVideoDataFromJson(json)
                }
            }
                
            catch {
                print("Failed to parse data: \(error)")
            }
            
            return [Video]()
        }

        
    
}



