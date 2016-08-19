//
//  MusicVideTableViewCell.swift
//  MusicVideo
//
//  Created by Jim Hubbard on 8/19/16.
//  Copyright © 2016 Jim Hubbard. All rights reserved.
//

import UIKit

class MusicVideTableViewCell: UITableViewCell {
    
    var video: Videos? {
        didSet {
            updateCell()
        }
        
    }


    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var musicTitle: UILabel!

//    @IBOutlet weak var musicImage: UIImageView!
//    @IBOutlet weak var rank: UILabel!
//    @IBOutlet weak var musicTitle: UILabel!


    func updateCell() {

        musicTitle.text = video?.vName
        rank.text = ("\(video!.vRank)")
        musicImage.image = UIImage(named: "imageNotAvailable")
        
        
    }
    
}
