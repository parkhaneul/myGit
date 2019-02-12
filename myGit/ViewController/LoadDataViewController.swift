//
//  LoadDataViewController.swift
//  myGit
//
//  Created by 박하늘 on 22/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

class LoadDataViewController : UIViewController{
    //var repoData : [Repository] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.performSegue(withIdentifier: "homeSegue", sender: self)
    }
}
