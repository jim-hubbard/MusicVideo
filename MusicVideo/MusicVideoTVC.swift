//
//  MusicVideoTVC.swift
//  MusicVideo
//
//  Created by Jim Hubbard on 8/18/16.
//  Copyright © 2016 Jim Hubbard. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController {

    var videos = [Video]()
    
    var filterSearch = [Video]()
    
    let resultSearchController = UISearchController(searchResultsController: nil)
    
    var limit = 10
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        #if swift(>=2.2)
          
            
            NotificationCenter.default.addObserver(self, selector: #selector(MusicVideoTVC.reachabilityStatusChanged), name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(preferredFontChanged), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
            #else
            
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachablityStatusChanged"), name: "ReachStatusChanged", object: nil)
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector:("preferredFontChanged"), name: UIContentSizeCategoryDidChangeNotification, object: nil)
            
        #endif
        
        reachabilityStatusChanged()
        

    }
    
    func preferredFontChanged(){
        print("The preferred font has changed"
        )
    }
    
    func didLoadData(_ videos: [Video]) {
        
        //print(reachabilityStatus)
        
        //Use these if you do set this on the storyboard
        //tableView.dataSource = self
        //tableView.delegate = self
        
        
        self.videos = videos

        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.red]
        
        title = ("The iTunes Top \(limit) Music Videos")
        
        
        //Set up search controller
        
        resultSearchController.searchResultsUpdater = self
        
        definesPresentationContext = true
       
        //resultSearchController.obscuresBackgroundDuringPresentation = true
        
        resultSearchController.dimsBackgroundDuringPresentation = false
        
        resultSearchController.searchBar.placeholder = "Search for Artist, Name or Rank"
        resultSearchController.searchBar.searchBarStyle = UISearchBarStyle.prominent
        
        //add searchbar to your tableview
        tableView.tableHeaderView = resultSearchController.searchBar
        
        
        
        tableView.reloadData()
        
    }
    
    func reachabilityStatusChanged() {
        
        switch reachabilityStatus {
        case NOACCESS:
            //view.backgroundColor = UIColor.redColor()
            //Move to th main thread
            DispatchQueue.main.async
            {
                
                let alert = UIAlertController(title: "No Internet Access", message: "Please make sure you are connected to the Internet", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .default) {
                    action -> () in
                    print("Cancel")
                }
                
                let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {
                    action -> () in
                    print("Delete")
                }
                
                let okAction = UIAlertAction(title: "OK", style: .default) {
                    action -> () in
                    print("OK")
                }
                
                alert.addAction(okAction)
                alert.addAction(cancelAction)
                alert.addAction(deleteAction)
                
                self.present(alert, animated: true, completion: nil)
                
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
    
    
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        
        refreshControl?.endRefreshing()
        
        if resultSearchController.isActive {
                    refreshControl?.attributedTitle = NSAttributedString(string: "No refresh allowed during search")
        }else {
                   runAPI()
        }
        

        

    }
    
    func getAPICount() {
        
        if (UserDefaults.standard.object(forKey: "APICNT") != nil) {
            
            let theValue = UserDefaults.standard.object(forKey: "APICNT") as! Int
            limit = theValue
            
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MM yyyy HH:ss"
        let refreshDte = formatter.string(from: Date())
        
        refreshControl?.attributedTitle = NSAttributedString(string: "\(refreshDte)")
        
    
    }
    
    func runAPI() {
        
        getAPICount()
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=\(limit)/json", completion: didLoadData)
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self,name:NSNotification.Name(rawValue: "ReachStatisChanged"),object: nil)

        NotificationCenter.default.removeObserver(self,name:NSNotification.Name.UIContentSizeCategoryDidChange,object: nil)
        
    }
    

    
    //MARK - tableView data source
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        

        if resultSearchController.isActive {
            return filterSearch.count
        }
        return videos.count
    
    }

    fileprivate struct storyboard {
        static let cellReuseIndetifier = "cell"
        static  let segueIndetifier = "musicDetail"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: storyboard.cellReuseIndetifier, for: indexPath) as! MusicVideTableViewCell

        
        if resultSearchController.isActive {
            cell.video = filterSearch[(indexPath as NSIndexPath).row]
        }else {
            cell.video = videos[(indexPath as NSIndexPath).row]
        }
        
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == storyboard.segueIndetifier {
            if let indexpath = tableView.indexPathForSelectedRow {
                let video: Video
                
                if resultSearchController.isActive {
                    video = filterSearch[(indexpath as NSIndexPath).row]
                                
                }else {
                    video = videos[(indexpath as NSIndexPath).row]
                }
                
                let dvc = segue.destination as! MusicVideoDetailVC
                dvc.videos = video
            }
        }
    }
 
//    func updateSearchResultsForSearchController(searchController: UISearchController) {
//        searchController.searchBar.text!.lowercaseString
//        filterSearch(searchController.searchBar.text!)
//        
//    }

    
    //Added the check on the searchString so that the display does blank out 
    //when you have a empty string in the search bar...
    func filterSearch(_ searchText:String) {
        
        if searchText == "" {
            filterSearch = videos
        }else {
            
            filterSearch = videos.filter { videos in
                return videos.vArtist.lowercased().contains(searchText.lowercased()) || videos.vName.lowercased().contains(searchText.lowercased()) || "\(videos.vRank)".lowercased().contains(searchText.lowercased())       }
            
        }
        tableView.reloadData()
    }
    
}

extension MusicVideoTVC: UISearchResultsUpdating {
    
        func updateSearchResults(for searchController: UISearchController) {
            //searchController.searchBar.text!.lowercased()
            filterSearch(searchController.searchBar.text!.lowercased())
    
    }

}
