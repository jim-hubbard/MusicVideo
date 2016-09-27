//
//  AboutVC.swift
//  MusicVideo
//
//  Created by Jim Hubbard on 8/31/16.
//  Copyright © 2016 Jim Hubbard. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {

    @IBOutlet weak var labelAbout: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(preferredFontChanged), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
        
        title = "About"
        

        // Do any additional setup after loading the view.
    }


    func preferredFontChanged() {
        
        labelAbout.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
    }
    
    
    deinit {
        
        NotificationCenter.default.removeObserver(self,name:NSNotification.Name.UIContentSizeCategoryDidChange,object: nil)
        
    }
    
}
