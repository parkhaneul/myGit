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
    
    private var _data : Contents?
    var data : Contents?{
        get{
            return _data
        }
        set(newVal){
            _data = newVal
            guard newVal != nil else{
                return
            }
            draw()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContents()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func loadContents(){
        showSpinner(onView: self.view)
        GithubAPI().getFileByPath(path: path, completion: {(file) in
            if let file = file{
                self.data = file
            }
            self.stopSpinner()
        })
    }
    
    func draw(){
        DispatchQueue.main.async {
            self.fileName.text = self.data!.name
            let read = self.data!.content!
            self.content.text = read.decodeBase64()
            self.scroll.contentSize = self.content.intrinsicContentSize
        }
    }
}
