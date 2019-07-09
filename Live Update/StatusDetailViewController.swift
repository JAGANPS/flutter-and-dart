//
//  StatusDetailViewController.swift
//  Live Update
//
//  Created by Ronny Kibet on 4/14/15.
//  Copyright (c) 2015 TeamAppCreative. All rights reserved.
//

import UIKit

class StatusDetailViewController: UIViewController {
    
    //items to receive
    var status: String?

    @IBOutlet weak var statusDetailLabel: UILabel!
    
    override func viewDidLoad() {
        
        statusDetailLabel.text = status
        statusDetailLabel.numberOfLines = 0
        statusDetailLabel.sizeToFit()
        
        
    }
}
