//
//  CustomNavigationViewController.swift
//  myGit
//
//  Created by 박하늘 on 16/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

class CustomNavigationViewController : UINavigationController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "gitlcon.png")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
    }
}
