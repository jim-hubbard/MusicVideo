//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by Jim Hubbard on 8/10/16.
//  Copyright © 2016 Jim Hubbard. All rights reserved.
//

import Foundation

class Videos {
    
    //Hold the index
    var vRank = 0
    
    // Data Encapsulation
    
    private var _vName:String
    private var _vRights:String
    private var _vPrice:String
    private var _vImageUrl:String
    private var _vArtist:String
    private var _vVideoUrl:String
    private var _vImid:String
    private var _vGenre:String
    private var _vLinkToiTunes:String
    private var _vReleaseDte:String
    
    
    //This variable gets created from the UI
    var vImageData:NSData?
    
    //Make a getter
    
    var vName: String {
        return _vName
    }
    
    var vRights: String {
        return _vRights
    }
    
    var vPrice: String {
        return _vPrice
    }
    
    var vImageUrl: String {
        return _vImageUrl
    }

    var vArtist: String {
        return _vArtist
    }
    
    var vVideoUrl: String {
        return _vVideoUrl
    }

    var vImid: String {
        return _vImid
    }
    
    var vGenre: String {
        return _vGenre
    }
    
    var vLinkToiTunes: String {
        return _vLinkToiTunes
    }
    
    var vReleaseDte: String {
        return _vReleaseDte
    }
    
    
    init(data: JSONDictionary) {
        
        //If we do not initialize all properties we will get error message
        //Return from initializer without initializing all stored properties
        
        
        // Video name~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        if let name = data["im:name"] as? JSONDictionary,
            vName = name["label"] as? String {
            self._vName = vName
        }
        else
        {
            //You may not always get data back from the JSON - you may want to display message
            // element in the JSON is unexpected
            
            _vName = ""
        }
        
        
        // Video Rights~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        if let rights = data["rights"] as? JSONDictionary,
            vRights = rights["label"] as? String {
            self._vRights = vRights
        }
        else
        {
            _vRights = ""
        }
        
        // Video Price~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        if let price = data["im:price"] as? JSONDictionary,
            vPrice = price["label"] as? String {
            self._vPrice = vPrice
        }
        else
        {
            _vPrice = ""
        }
        
        
        // The Video ImageURL~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        //Determing the size of the video to get if the user wants to check for that (from settings)
        var sizeText = "600x600"
        if NSUserDefaults().boolForKey("BestImageSettings") {
            switch reachabilityStatus {
            case WWAN:
                sizeText = "300x300"
            default:
                sizeText = "600x600"
            }
            
        }
        
        
        if let img = data["im:image"] as? JSONArray,
            image = img[2] as? JSONDictionary,immage = image["label"] as? String {_vImageUrl = immage.stringByReplacingOccurrencesOfString("100x100", withString: sizeText)
        }
        else
        {
            _vImageUrl = ""
        }
        
        // Video Artist~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        if let artist = data["im:artist"] as? JSONDictionary,
            vArtist = artist["label"] as? String {
            self._vArtist = vArtist
        }
        else
        {
            _vArtist = ""
        }
        
        
        //Video Url~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        if let video = data["link"] as? JSONArray,
            vUrl = video[1] as? JSONDictionary,
            vHref = vUrl["attributes"] as? JSONDictionary,
            vVideoUrl = vHref["href"] as? String {
            self._vVideoUrl = vVideoUrl
        }
        else
        {
            _vVideoUrl = ""
        }

        
        //Video Imid~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        if let imid = data["id"] as? JSONDictionary,
            vImidAttr = imid["attributes"] as? JSONDictionary,
            vImid = vImidAttr["im:id"] as? String {
            self._vImid = vImid
        }
        else
        {
            _vImid = ""
        }
        
        
        //Video Genre~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        if let Genre = data["category"] as? JSONDictionary,
            vGenreAttr = Genre["attributes"] as? JSONDictionary,
            vGenre = vGenreAttr["term"] as? String {
            self._vGenre = vGenre
        }
        else
        {
            _vGenre = ""
        }


        // Video LinkToiTunes~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        if let linkToiTunes = data["id"] as? JSONDictionary,
            vLinkToiTunes = linkToiTunes["label"] as? String {
            self._vLinkToiTunes = vLinkToiTunes
        }
        else
        {
            _vLinkToiTunes = ""
        }
        
        
        //Video ReleaseDte~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        if let ReleaseDte = data["im:releaseDate"] as? JSONDictionary,
            vReleaseDteAttr = ReleaseDte["attributes"] as? JSONDictionary,
            vReleaseDte = vReleaseDteAttr["label"] as? String {
            self._vReleaseDte = vReleaseDte
        }
        else
        {
            _vReleaseDte = ""
        }

        
    
    }
}

