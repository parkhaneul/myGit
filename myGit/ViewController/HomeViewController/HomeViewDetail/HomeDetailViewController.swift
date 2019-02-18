//
//  HomeDetailViewController.swift
//  myGit
//
//  Created by 박하늘 on 23/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

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
    
    private var _data : Repository?
    var data : Repository?{
        get{
            return _data
        }
        set(newVal){
            _data = newVal
        }
    }
    
    var rmData : Contents? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGesture(.left)
        readMeDownload()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func readMeDownload(){
        showSpinner(onView: self.view)
        let url = data!.url! + "/readme"
        GithubAPI().getReadMe(full_path: url){(readMeData) in
            if let readMeData = readMeData{
                self.rmData = readMeData
                self.drawContent(self.rmData!.content!)
                self.draw()
            }
            self.stopSpinner()
        }
    }
    
    func draw(){
        let user = data!.owner!
        let created = data!.created_at!
        let updated = data!.updated_at!
        let lang = data!.language
        let watcher = data!.watchers ?? 0
        let stargazers = data!.stargazers_count ?? 0
        let forks = data!.forks ?? 0
        
        DispatchQueue.main.async {
            self.watch.text = String(watcher)
            self.star.text = String(stargazers)
            self.fork.text = String(forks)
            
            self.userName.text = user.login
            self.gitName.text = "/" + self.data!.name!
            self.created_at.text = "Created at " + created.splitToOffset(offsetBy: 10)
            self.lastest_commit_at.text = "Lastest update at " + updated.splitToOffset(offsetBy: 10)
            
            self.language.text = lang
            self.language.textColor = ColorDictionary().getColor(language: lang)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! RepoContentViewController
        let user = data?.owner
        vc.path = user!.login! + "/" + data!.name! + "/contents/"
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
        DispatchQueue.main.async {
            self.readMe.text = str.decodeBase64()
            self.scroll.contentSize = self.readMe.intrinsicContentSize
        }
    }
    
    func setData(_ data :Repository){
        self.data = data
    }
}
