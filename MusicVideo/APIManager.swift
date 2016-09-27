//
//  APIManager.swift
//  MusicVideo
//
//  Created by Jim Hubbard on 8/5/16.
//  Copyright © 2016 Jim Hubbard. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(_ urlString:String, completion: @escaping ([Video]) -> Void ) {
        
        
        let config = URLSessionConfiguration.ephemeral
        
        let session = URLSession(configuration: config)
        
        
        //        let session = NSURLSession.sharedSession()
        let url = URL(string: urlString)!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) -> Void in
            
            if error != nil {
                print(error!.localizedDescription)
                
            } else {
                
                let videos = self.parseJason(data)
                
                
                //let priority = DispatchQueue.GlobalQueuePriority.high
                DispatchQueue.global(qos: .default).sync {
                //DispatchQueue.global(priority: priority).async {
                    DispatchQueue.main.async {
                        completion(videos)
                    }
                }
            }
            
        }) 
        task.resume()
    }
    
    func parseJason(_ data: Data?) -> [Video] {
            
            do {
                
                if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as AnyObject? {
                    
                    return JsonDataExtractor.extractVideoDataFromJson(json)
                }
            }
                
            catch {
                print("Failed to parse data: \(error)")
            }
            
            return [Video]()
        }

        
    
}



