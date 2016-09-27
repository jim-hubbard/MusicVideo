//
//  JsonDataExtractor.swift
//  MusicVideo
//
//  Created by Jim Hubbard on 9/12/16.
//  Copyright © 2016 Jim Hubbard. All rights reserved.
//

import Foundation

class JsonDataExtractor {
    
    static func extractVideoDataFromJson(_ videoDataObject:AnyObject) -> [Video] {
        
        guard let videoData = videoDataObject as? JSONDictionary else { return [Video]() }
        
        var videos = [Video]()
        
        if let feeds = videoData["feed"] as? JSONDictionary, let entries = feeds["entry"] as? JSONArray {
            
            for (index, data) in entries.enumerated() {
                
                
                var vName = " ", vRights = "", vPrice = "", vImageUrl = "",
                vArtist = "", vVideoUrl = "", vImid = "", vGenre = "",
                vLinkToiTunes = "", vReleaseDte = ""
                
                
                // Video name
                if let imName = data["im:name"] as? JSONDictionary,
                    let label = imName["label"] as? String {
                    vName = label
                }
                
                // Video Rights~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                if let rightsDict = data["rights"] as? JSONDictionary,
                    let label = rightsDict["label"] as? String {
                    vRights = label
                }
                
                // Price of Video
                
                if let imPrice = data["im:price"] as? JSONDictionary,
                    let label = imPrice["label"] as? String {
                    vPrice = label
                }
                
                
                // The Video ImageURL~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                //Determing the size of the video to get if the user wants to check for that (from settings)
                var sizeText = "600x600"
                if UserDefaults().bool(forKey: "BestImageSettings") {
                    switch reachabilityStatus {
                    case WWAN:
                        sizeText = "300x300"
                    default:
                        sizeText = "600x600"
                    }
                    
                }
                
                
                if let img = data["im:image"] as? JSONArray,
                    let image = img[2] as? JSONDictionary,let immage = image["label"] as? String {vImageUrl = immage.replacingOccurrences(of: "100x100", with: sizeText)
                }
                
                
                // Video Artist~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                if let id = data["id"] as? JSONDictionary,
                    let attributes = id["attributes"] as? JSONDictionary,
                    let Imid = attributes["im:id"] as? String {
                    vImid = Imid
                }
                
                
                
                //Video Url~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                if let link = data["link"] as? JSONArray,
                    let vUrl = link[1] as? JSONDictionary,
                    let attributes = vUrl["attributes"] as? JSONDictionary,
                    let href = attributes["href"] as? String {
                    vVideoUrl = href
                }
                
                
                
                //Video Imid~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                if let id = data["id"] as? JSONDictionary,
                    let attributes = id["attributes"] as? JSONDictionary,
                    let Imid = attributes["im:id"] as? String {
                    vImid = Imid
                }
                
                
                
                //Video Genre~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                if let category = data["category"] as? JSONDictionary,
                    let attributes = category["attributes"] as? JSONDictionary,
                    let term = attributes["term"] as? String {
                    vGenre = term
                }
                
                
                
                // Video LinkToiTunes~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                if let id = data["id"] as? JSONDictionary,
                    let label = id["label"] as? String {
                    vLinkToiTunes = label
                }
                
                
                //Video ReleaseDte~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                if let imReleaseDate = data["im:releaseDate"] as? JSONDictionary,
                    let attributes = imReleaseDate["attributes"] as? JSONDictionary,
                    let label = attributes["label"] as? String {
                    vReleaseDte = label
                }
                
                
                
                
                let currentVideo = Video(vRank: index + 1, vName: vName, vRights: vRights, vPrice: vPrice, vImageUrl: vImageUrl, vArtist: vArtist, vVideoUrl: vVideoUrl, vImid: vImid, vGenre: vGenre, vLinkToiTunes: vLinkToiTunes, vReleaseDte: vReleaseDte)
                
                
                
                videos.append(currentVideo)
                
                
            }
            
        }
        
        
        return videos
    }
    
}
