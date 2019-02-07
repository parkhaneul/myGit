//
//  ConnectFailViewController.swift
//  myGit
//
//  Created by 박하늘 on 07/02/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

class ConnectFailViewController : UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    static func showErrorView(_ vc : UIViewController){
        let story = vc.storyboard!
        let ev = story.instantiateViewController(withIdentifier: "ErrorView") as! ConnectFailViewController
        DispatchQueue.main.async {
            vc.present(ev, animated: true, completion: nil)
        }
    }
}
