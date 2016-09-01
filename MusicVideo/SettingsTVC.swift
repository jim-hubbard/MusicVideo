//
//  SettingsTVCTableViewController.swift
//  MusicVideo
//
//  Created by Jim Hubbard on 8/31/16.
//  Copyright © 2016 Jim Hubbard. All rights reserved.
//

import UIKit

class SettingsTVC: UITableViewController {

    
    @IBOutlet weak var aboutDisplay: UILabel!
    @IBOutlet weak var feedBackDisplay: UILabel!
    @IBOutlet weak var securityDisplay: UILabel!
    @IBOutlet weak var touchID: UISwitch!
    @IBOutlet weak var bestImageDisplay: UILabel!
    @IBOutlet weak var APICnt: UILabel!
    @IBOutlet weak var sliderCnt: UISlider!
    
    @IBOutlet weak var drafTheSliderDisplay: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(preferredFontChanged), name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        tableView.alwaysBounceVertical = false
        
        title = "Settings"
    
        touchID.on = NSUserDefaults.standardUserDefaults().boolForKey("SecSettings")

        if (NSUserDefaults.standardUserDefaults().objectForKey("APICNT") != nil) {
            
            let theValue = NSUserDefaults.standardUserDefaults().objectForKey("APICNT") as! Int
                APICnt.text = "Number Of Music Videos \(theValue)"
                sliderCnt.value = Float(theValue)
        } else {
            sliderCnt.value = 10.0
        APICnt.text = ("Number Of Music Videos \(Int(sliderCnt.value))")
        }
        
    }

    @IBAction func touchIDSec(sender: UISwitch) {
        
      let defaults = NSUserDefaults.standardUserDefaults()
        if touchID.on {
            defaults.setBool(touchID.on, forKey: "SecSettings")
        }
        else{
            defaults.setBool(false, forKey: "SecSettings")
        }
        
    }
    
    
    
    @IBAction func valueChanged(sender: AnyObject) {
     
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(Int(sliderCnt.value), forKey: "APICNT")
        APICnt.text = ("Number Of Music Videos \(Int(sliderCnt.value))")
        

    }
    
    
    func preferredFontChanged() {
        
        aboutDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        feedBackDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        securityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        bestImageDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        APICnt.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        drafTheSliderDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
        
        
        
    }
    
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(self,name:UIContentSizeCategoryDidChangeNotification,object: nil)
        
    }

}