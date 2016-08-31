//
//  MusicVideoDetailVCViewController.swift
//  MusicVideo
//
//  Created by Jim Hubbard on 8/29/16.
//  Copyright © 2016 Jim Hubbard. All rights reserved.
//

import UIKit

class MusicVideoDetailVC: UIViewController {

    var videos: Videos!

    @IBOutlet weak var vName: UILabel!
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var vGenre: UILabel!
    @IBOutlet weak var vPrice: UILabel!
    @IBOutlet weak var vRights: UILabel!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        title = videos.vArtist
        vName.text = videos.vName
        vPrice.text = videos.vPrice
        vRights.text = videos.vRights
        vGenre.text = videos.vGenre

        if videos.vImageData != nil {
            videoImage.image = UIImage(data: videos.vImageData!)
        }
        else {
            videoImage.image = UIImage(named: "imageNotAvaialble")
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(preferredFontChanged), name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        
        
    }

    func preferredFontChanged() {
        
        vName.font = UIFont.preferredFontForTextStyle("headline")
        vPrice.font = UIFont.preferredFontForTextStyle("headline")
        vRights.font = UIFont.preferredFontForTextStyle("headline")
        vGenre.font = UIFont.preferredFontForTextStyle("headline")
        
        
    }
    
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(self,name:UIContentSizeCategoryDidChangeNotification,object: nil)
        
    }
}
