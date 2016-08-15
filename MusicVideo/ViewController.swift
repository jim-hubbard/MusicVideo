//
//  ViewController.swift
//  MusicVideo
//
//  Created by Jim Hubbard on 8/5/16.
//  Copyright © 2016 Jim Hubbard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var videos = [Videos]()
    
    @IBOutlet weak var DisplayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged), name: "ReachStatusChanged", object: nil)
        
        reachabilityStatusChanged()
        
        
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
    }
    
    func didLoadData(videos: [Videos]) {
        
        print(reachabilityStatus)
        
        
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
    
    func reachabilityStatusChanged() {
        
        switch reachabilityStatus {
        case NOACCESS: view.backgroundColor = UIColor.redColor()
            DisplayLabel.text = "No Internet"
        case WIFI: view.backgroundColor = UIColor.greenColor()
            DisplayLabel.text = "Reachable with WIFI"
        case WWAN :view.backgroundColor = UIColor.yellowColor()
            DisplayLabel.text = "Reachable with Celluar"
        default:return
            
        }

            
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self,name:"ReachStatisChanged",object: nil)
    
    }
    
    
    
}

