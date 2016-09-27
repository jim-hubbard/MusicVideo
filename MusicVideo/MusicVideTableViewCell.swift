//
//  MusicVideTableViewCell.swift
//  MusicVideo
//
//  Created by Jim Hubbard on 8/19/16.
//  Copyright © 2016 Jim Hubbard. All rights reserved.
//

import UIKit

class MusicVideTableViewCell: UITableViewCell {
    
    var video: Video? {
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
        
        musicTitle.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        rank.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)

        musicTitle.text = video?.vName
        rank.text = ("\(video!.vRank)")
        //musicImage.image = UIImage(named: "imageNotAvailable")
        
        if video?.vImageData != nil {
            print("Get data from array ...")
            musicImage.image = UIImage(data: video!.vImageData! as Data)
        } else {
            getVideoImage(video!, imageView: musicImage)
            print ("get images in background thread")
        }
        
        
    }
    
    
/*!
 * @typedef dispatch_queue_priority_t
 * Type of dispatch_queue_priority
 *
 * @constant DISPATCH_QUEUE_PRIORITY_HIGH
 * Items dispatched to the queue will run at high priority,
 * i.e. the queue will be scheduled for execution before
 * any default priority or low priority queue.
 *
 * @constant DISPATCH_QUEUE_PRIORITY_DEFAULT
 * Items dispatched to the queue will run at the default
 * priority, i.e. the queue will be scheduled for execution
 * after all high priority queues have been scheduled, but
 * before any low priority queues have been scheduled.
 *
 * @constant DISPATCH_QUEUE_PRIORITY_LOW
 * Items dispatched to the queue will run at low priority,
 * i.e. the queue will be scheduled for execution after all
 * default priority and high priority queues have been
 * scheduled.
 *
 * @constant DISPATCH_QUEUE_PRIORITY_BACKGROUND
 * Items dispatched to the queue will run at background priority, i.e. the queue
 * will be scheduled for execution after all higher priority queues have been
 * scheduled and the system will run items on this queue on a thread with
 * background status as per setpriority(2) (i.e. disk I/O is throttled and the
 * thread's scheduling priority is set to lowest value).
 */
    func getVideoImage(_ video: Video, imageView: UIImageView) {
        
        
        DispatchQueue.global(qos: .default).sync {
        //DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async {
            
            let data = try? Data(contentsOf: URL(string:video.vImageUrl)!)
            
            var image : UIImage?
            if data != nil {
                video.vImageData = data
                image = UIImage(data: data!)
            }
            
            //move back to the Main Queue
            DispatchQueue.main.async {
                imageView.image = image
            }
            
        }
        
        
    }
    
}
