//
//  MusicVideoTVC.swift
//  MusicVideo
//
//  Created by Jim Hubbard on 8/18/16.
//  Copyright © 2016 Jim Hubbard. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController {

    var videos = [Videos]()
    var limit = 10
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged), name: "ReachStatusChanged", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(preferredFontChanged), name: UIContentSizeCategoryDidChangeNotification, object: nil)

        
        reachabilityStatusChanged()
        

    }
    
    func preferredFontChanged(){
        print("The preferred font has changed"
        )
    }
    
    func didLoadData(videos: [Videos]) {
        
        print(reachabilityStatus)
        
        //Use these if you do set this on the storyboard
        //tableView.dataSource = self
        //tableView.delegate = self
        
        
        self.videos = videos
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.redColor()]
        
        title = ("The iTunes Top \(limit) Music Videos")
        
        tableView.reloadData()
        
    }
    
    func reachabilityStatusChanged() {
        
        switch reachabilityStatus {
        case NOACCESS:
            //view.backgroundColor = UIColor.redColor()
            //Move to th main thread
            dispatch_async(dispatch_get_main_queue())
            {
                
                let alert = UIAlertController(title: "No Internet Access", message: "Please make sure you are connected to the Internet", preferredStyle: .Alert)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
                    action -> () in
                    print("Cancel")
                }
                
                let deleteAction = UIAlertAction(title: "Delete", style: .Destructive) {
                    action -> () in
                    print("Delete")
                }
                
                let okAction = UIAlertAction(title: "OK", style: .Default) {
                    action -> () in
                    print("OK")
                }
                
                alert.addAction(okAction)
                alert.addAction(cancelAction)
                alert.addAction(deleteAction)
                
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
            
        //DisplayLabel.text = "No Internet"
        //case WIFI: view.backgroundColor = UIColor.greenColor()
        //DisplayLabel.text = "Reachable with WIFI"
        //case WWAN :view.backgroundColor = UIColor.yellowColor()
        //DisplayLabel.text = "Reachable with Celluar"
        
        default:
            //view.backgroundColor = UIColor.greenColor()
            
            if videos.count > 0 {
                print("Not running API")
            } else {
                runAPI()
            }
            
        }
        
        
    }
    
    
    
    @IBAction func refresh(sender: UIRefreshControl) {
        
        refreshControl?.endRefreshing()
        runAPI()
        

    }
    
    func getAPICount() {
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("APICNT") != nil) {
            
            let theValue = NSUserDefaults.standardUserDefaults().objectForKey("APICNT") as! Int
            limit = theValue
            
        }
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "E, dd MM yyyy HH:ss"
        let refreshDte = formatter.stringFromDate(NSDate())
        
        refreshControl?.attributedTitle = NSAttributedString(string: "\(refreshDte)")
        
    
    }
    
    func runAPI() {
        
        getAPICount()
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=\(limit)/json", completion: didLoadData)
    }
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self,name:"ReachStatisChanged",object: nil)

        NSNotificationCenter.defaultCenter().removeObserver(self,name:UIContentSizeCategoryDidChangeNotification,object: nil)
        
    }
    

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videos.count
    }

    private struct storyboard {
        static let cellReuseIndetifier = "cell"
        static  let segueIndetifier = "musicDetail"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier(storyboard.cellReuseIndetifier, forIndexPath: indexPath) as! MusicVideTableViewCell

        cell.video = videos[indexPath.row]
        
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == storyboard.segueIndetifier {
            if let indexpath = tableView.indexPathForSelectedRow {
                let video = videos[indexpath.row]
                let dvc = segue.destinationViewController as! MusicVideoDetailVC
                dvc.videos = video
            }
        }
        
    }
    
}
