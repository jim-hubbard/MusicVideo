//
//  ViewController.swift
//  MusicVideo
//
//  Created by Jim Hubbard on 8/5/16.
//  Copyright © 2016 Jim Hubbard. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    var videos = [Videos]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var DisplayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged), name: "ReachStatusChanged", object: nil)
        
        reachabilityStatusChanged()
        
        
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=50/json", completion: didLoadData)
    }
    
    func didLoadData(videos: [Videos]) {
        
        print(reachabilityStatus)
        
        //Use these if you do set this on the storyboard
        tableView.dataSource = self
        tableView.delegate = self
        
        
        self.videos = videos
        
//        for (index,item) in videos.enumerate() {
//            print("\(index) Name = \(item.vName)")
//            print("Rights = \(item.vRights)")
//            print("Price = \(item.vPrice)")
//            print("ImageURL = \(item.vImageUrl)")
//            print("Artist = \(item.vArtist)")
//            print("VideoURL = \(item.vVideoUrl)")
//            print("Imid = \(item.vImid)")
//            print("Genre = \(item.vGenre)")
//            print("LinkToiTunes = \(item.vLinkToiTunes)")
//            print("ReleaseDate = \(item.vReleaseDte)")
//        }
        
        tableView.reloadData()
        
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
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let video = videos[indexPath.row]
        
        cell.textLabel?.text = ("\(indexPath.row + 1)" )
        
        cell.detailTextLabel?.text = video.vName
        
        return cell
        
    }
    
    

    
}

