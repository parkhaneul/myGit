//
//  HomeDetailViewController.swift
//  myGit
//
//  Created by 박하늘 on 23/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

struct HomeDetailViewControllerModel{
    var data : Repository?
    var rmData : Contents?
}

class HomeDetailViewController : UIViewController{
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var gitName: UILabel!
    @IBOutlet weak var created_at: UILabel!
    @IBOutlet weak var lastest_commit_at: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var readMe: UILabel!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var watch: UILabel!
    @IBOutlet weak var star: UILabel!
    @IBOutlet weak var fork: UILabel!
    
    var viewModel = HomeDetailViewControllerModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGesture(.left)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readMeDownload()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func readMeDownload(){
        showSpinner(onView: self.view)
        let url = viewModel.data!.url! + "/readme"
        GithubAPI().getReadMe(full_path: url){(readMeData) in
            if let readMeData = readMeData{
                self.viewModel.rmData = readMeData
                DispatchQueue.main.async {
                    self.drawContent(self.viewModel.rmData!.content!)
                    self.draw(self.viewModel.data!)
                }
            }
            self.stopSpinner()
        }
    }
    
    func draw(_ data : Repository){
        self.watch.text = String(data.watchers ?? 0)
        self.star.text = String(data.stargazers_count ?? 0)
        self.fork.text = String(data.forks ?? 0)
            
        self.userName.text = data.owner!.login
        self.gitName.text = "/" + data.name!
        self.created_at.text = "Created at " + data.created_at!.splitToOffset(offsetBy: 10)
        self.lastest_commit_at.text = "Lastest update at " + data.updated_at!.splitToOffset(offsetBy: 10)
            
        self.language.text = data.language
        self.language.textColor = ColorDictionary().getColor(language: data.language)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! RepoContentViewController
        let user = viewModel.data?.owner
        vc.viewModel.path = user!.login! + "/" + viewModel.data!.name! + "/contents/"
    }
    
    func setGesture(_ direction : UISwipeGestureRecognizer.Direction){
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture: )))
        swipe.direction = direction
        self.view.addGestureRecognizer(swipe)
    }
    
    @objc func handleGesture(gesture : UISwipeGestureRecognizer){
        if gesture.direction == UISwipeGestureRecognizer.Direction.left{
            self.performSegue(withIdentifier: "contentSegue", sender: self)
        }
    }
    
    func drawContent(_ str : String){
        self.readMe.text = str.decodeBase64()
        self.scroll.contentSize = self.readMe.intrinsicContentSize
    }
    
    func setData(_ data :Repository){
        viewModel.data = data
    }
}
