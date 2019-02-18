//
//  FileDetailViewController.swift
//  myGit
//
//  Created by 박하늘 on 25/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

struct FileDetailViewControllerModel{
    var path : String = ""
    var data : Contents?
}

class FileDetailViewController : UIViewController{
    @IBOutlet weak var fileName: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var scroll: UIScrollView!
    
    var viewModel = FileDetailViewControllerModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContents()
    }
    
    func loadContents(){
        showSpinner(onView: self.view)
        GithubAPI().getFileByPath(path: viewModel.path, completion: {(file) in
            if let file = file{
                self.viewModel.data = file
                self.draw()
            }
            self.stopSpinner()
        })
    }
    
    func draw(){
        DispatchQueue.main.async {
            self.fileName.text = self.viewModel.data!.name
            let read = self.viewModel.data!.content!
            self.content.text = read.decodeBase64()
            self.scroll.contentSize = self.content.intrinsicContentSize
        }
    }
}
