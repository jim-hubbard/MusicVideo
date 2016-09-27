//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by Jim Hubbard on 8/10/16.
//  Copyright © 2016 Jim Hubbard. All rights reserved.
//

import Foundation

class Video {
    
    
    
    // Data encapsulation
    fileprivate(set) var vRank:Int
    fileprivate(set) var vName:String
    fileprivate(set) var vRights:String
    fileprivate(set) var vPrice:String
    fileprivate(set) var vImageUrl:String
    fileprivate(set) var vArtist:String
    fileprivate(set) var vVideoUrl:String
    fileprivate(set) var vImid:String
    fileprivate(set) var vGenre:String
    fileprivate(set) var vLinkToiTunes:String
    fileprivate(set) var vReleaseDte:String
    
    // This variable gets created from the UI
    var vImageData:Data?
    
    
    
    init(vRank:Int, vName:String, vRights:String, vPrice:String,
         vImageUrl:String, vArtist:String, vVideoUrl:String, vImid:String,
         vGenre:String, vLinkToiTunes:String, vReleaseDte:String) {
        
        
        self.vRank = vRank
        self.vName = vName
        self.vRights = vRights
        self.vPrice = vPrice
        self.vImageUrl = vImageUrl
        self.vArtist = vArtist
        self.vVideoUrl = vVideoUrl
        self.vImid = vImid
        self.vGenre = vGenre
        self.vLinkToiTunes = vLinkToiTunes
        self.vReleaseDte = vReleaseDte
        
    }
}

