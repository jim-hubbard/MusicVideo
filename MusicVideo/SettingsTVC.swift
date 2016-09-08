//
//  SettingsTVCTableViewController.swift
//  MusicVideo
//
//  Created by Jim Hubbard on 8/31/16.
//  Copyright © 2016 Jim Hubbard. All rights reserved.
//

import UIKit
import MessageUI
import LocalAuthentication


class SettingsTVC: UITableViewController, MFMailComposeViewControllerDelegate {

    
    @IBOutlet weak var aboutDisplay: UILabel!
    @IBOutlet weak var feedBackDisplay: UILabel!
    @IBOutlet weak var securityDisplay: UILabel!
    @IBOutlet weak var touchID: UISwitch!
    @IBOutlet weak var bestImageDisplay: UILabel!
    @IBOutlet weak var APICnt: UILabel!
    @IBOutlet weak var sliderCnt: UISlider!
    
    @IBOutlet weak var bestImageQuality: UISwitch!
    @IBOutlet weak var drafTheSliderDisplay: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(preferredFontChanged), name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        tableView.alwaysBounceVertical = false
        
        title = "Settings"
    
        touchID.on = NSUserDefaults.standardUserDefaults().boolForKey("SecSettings")

        bestImageQuality.on = NSUserDefaults().boolForKey("BestImageSettings")
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("APICNT") != nil) {
            
            let theValue = NSUserDefaults.standardUserDefaults().objectForKey("APICNT") as! Int
                APICnt.text = "Number Of Music Videos \(theValue)"
                sliderCnt.value = Float(theValue)
        } else {
            sliderCnt.value = 10.0
        APICnt.text = ("Number Of Music Videos \(Int(sliderCnt.value))")
        }
        
        // Check if we can access local device authentication
        // Create the Local Authentication Context
        let context = LAContext()
        var touchIDError : NSError?
        
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error:&touchIDError) {
            //Enable the security switch
            touchID.enabled = true
        } else {
            touchID.on = false
            touchID.enabled = false
            securityDisplay.text = "Security Not Available on this Device"
        }
        
        
        
    }

    @IBAction func bestImageQuality(sender: UISwitch) {
       
        let defaults = NSUserDefaults.standardUserDefaults()
        if bestImageQuality.on {
            defaults.setBool(bestImageQuality.on, forKey: "BestImageSettings")
        }
        else{
            defaults.setBool(false, forKey: "BestImageSettings")
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
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        if indexPath.section == 0 && indexPath.row == 1 {
            
            let mailComposeViewController = configureMail()
            
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
                
                }
                else {
                    //No mail setup
                    mailAlert()
                }
            }
        
        }
     
        func configureMail() -> MFMailComposeViewController {
            
            let mailComposeVC = MFMailComposeViewController()
            mailComposeVC.mailComposeDelegate = self
            mailComposeVC.setToRecipients(["jim.hubbard@pacbell.net"])
            mailComposeVC.setSubject("Music Video App Feedback")
            mailComposeVC.setMessageBody("Hi Jim, \n \nGreat App, I would like to leave some feed back. \n", isHTML: false)
            
            return mailComposeVC
        }
    
        func mailAlert() {
            
            let alertController: UIAlertController = UIAlertController(title: "Alert", message: "No mail accounts setup on this device", preferredStyle: .Alert)
         
            let okAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
            
                //Do something?
            }
            
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: false, completion: nil)
            
        }

    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            print("Mail cancelled")
        case MFMailComposeResultSaved.rawValue:
            print("Mail saved")
        case MFMailComposeResultSent.rawValue:
            print("Mail sent")
        case MFMailComposeResultFailed.rawValue:
            print("Mail Failed")
        default:
            print("Unknown Issue")
        }
        self.dismissViewControllerAnimated(true, completion: nil)}
    
    
            
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(self,name:UIContentSizeCategoryDidChangeNotification,object: nil)
        
    }

}