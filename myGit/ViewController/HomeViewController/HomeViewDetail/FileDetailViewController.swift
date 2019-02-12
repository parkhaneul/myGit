//
//  FileDetailViewController.swift
//  myGit
//
//  Created by 박하늘 on 25/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

class FileDetailViewController : UIViewController{
    @IBOutlet weak var fileName: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var scroll: UIScrollView!
    
    var path : String = ""
    var data : Contents = Contents([:])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContents()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        data = Contents([:])
        super.viewDidDisappear(animated)
    }
    
    func loadContents(){
        showSpinner(onView: self.view)
        GithubAPI().getFileByPath(path: path, completion: {(response, error) in
            self.stopSpinner()
            if let response = response{
                self.data = Contents(response.toJson())
                DispatchQueue.main.async {
                    self.draw()
                }
            } else{
                ConnectFailViewController.showErrorView(self)
            }
        })
    }
    
    func draw(){
        fileName.text = data.get("name") as? String
        let read = data.get("content") as! String
        content.text = read.decodeBase64()
        scroll.contentSize = content.intrinsicContentSize
    }
}
