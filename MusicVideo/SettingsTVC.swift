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

        NotificationCenter.default.addObserver(self, selector: #selector(preferredFontChanged), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
        
        tableView.alwaysBounceVertical = false
        
        title = "Settings"
    
        touchID.isOn = UserDefaults.standard.bool(forKey: "SecSettings")

        bestImageQuality.isOn = UserDefaults().bool(forKey: "BestImageSettings")
        
        if (UserDefaults.standard.object(forKey: "APICNT") != nil) {
            
            let theValue = UserDefaults.standard.object(forKey: "APICNT") as! Int
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
        
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error:&touchIDError) {
            //Enable the security switch
            touchID.isEnabled = true
        } else {
            touchID.isOn = false
            touchID.isEnabled = false
            securityDisplay.text = "Security Not Available on this Device"
        }
        
        
        
    }

    @IBAction func bestImageQuality(_ sender: UISwitch) {
       
        let defaults = UserDefaults.standard
        if bestImageQuality.isOn {
            defaults.set(bestImageQuality.isOn, forKey: "BestImageSettings")
        }
        else{
            defaults.set(false, forKey: "BestImageSettings")
        }
        
    }
    
    
    @IBAction func touchIDSec(_ sender: UISwitch) {
        
      let defaults = UserDefaults.standard
        if touchID.isOn {
            defaults.set(touchID.isOn, forKey: "SecSettings")
        }
        else{
            defaults.set(false, forKey: "SecSettings")
        }
        
    }
    
    
    
    @IBAction func valueChanged(_ sender: AnyObject) {
     
        let defaults = UserDefaults.standard
        defaults.set(Int(sliderCnt.value), forKey: "APICNT")
        APICnt.text = ("Number Of Music Videos \(Int(sliderCnt.value))")
        

    }
    
    
    func preferredFontChanged() {
        
        aboutDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        feedBackDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        securityDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        bestImageDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        APICnt.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        drafTheSliderDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.footnote)
        
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if (indexPath as NSIndexPath).section == 0 && (indexPath as NSIndexPath).row == 1 {
            
            let mailComposeViewController = configureMail()
            
            if MFMailComposeViewController.canSendMail() {
                self.present(mailComposeViewController, animated: true, completion: nil)
                
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
            
            let alertController: UIAlertController = UIAlertController(title: "Alert", message: "No mail accounts setup on this device", preferredStyle: .alert)
         
            let okAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
            
                //Do something?
            }
            
            alertController.addAction(okAction)
            self.present(alertController, animated: false, completion: nil)
            
        }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            print("Mail cancelled")
        case MFMailComposeResult.saved.rawValue:
            print("Mail saved")
        case MFMailComposeResult.sent.rawValue:
            print("Mail sent")
        case MFMailComposeResult.failed.rawValue:
            print("Mail Failed")
        default:
            print("Unknown Issue")
        }
        self.dismiss(animated: true, completion: nil)}
    
    
            
    deinit {
        
        NotificationCenter.default.removeObserver(self,name:NSNotification.Name.UIContentSizeCategoryDidChange,object: nil)
        
    }

}
