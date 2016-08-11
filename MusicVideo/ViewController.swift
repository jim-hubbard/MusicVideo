//
//  ViewController.swift
//  MusicVideo
//
//  Created by Jim Hubbard on 8/5/16.
//  Copyright © 2016 Jim Hubbard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
    }
    
    func didLoadData(videos: [Videos]) {
        
        for (index,item) in videos.enumerate() {
            print("\(index) Name = \(item.vName)")
            print("Rights = \(item.vRights)")
            print("Price = \(item.vPrice)")
            print("ImageURL = \(item.vImageUrl)")
            print("Artist = \(item.vArtist)")
            print("VideoURL = \(item.vVideoUrl)")
            print("Imid = \(item.vImid)")
            print("Genre = \(item.vGenre)")
            print("LinkToiTunes = \(item.vLinkToiTunes)")
            print("ReleaseDate = \(item.vReleaseDte)")
        }
        
    }
    
    
}

