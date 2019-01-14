//
//  FirstViewController.swift
//  myGit
//
//  Created by 박하늘 on 14/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    var connect : WebConnection!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        connect = WebConnection()
        connect.getJSON(url: gitURL.base.rawValue + "/applications/grants")
    }
}

