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
    
    var data : Repository = Repository([:])
    var rmData : Contents = Contents([:])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        draw()
        readMeDownload()
        setGesture(.left)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        data = Repository([:])
        rmData = Contents([:])
        super.viewDidDisappear(animated)
    }
    
    func draw(){
        let user = data.get("owner") as! JSON
        let created = data.get("created_at") as! String
        let updated = data.get("updated_at") as! String
        let lang = data.get("language") as? String
        
        watch.text = String(data.get("watchers") as! Int)
        star.text = String(data.get("stargazers_count") as! Int)
        fork.text = String(data.get("forks") as! Int)
        
        userName.text = user["login"] as! String
        gitName.text = "/" + (data.get("name") as! String)
        
        created_at.text = "Created at " + created.splitToOffset(offsetBy: 10)
        lastest_commit_at.text = "Lastest update at " + updated.splitToOffset(offsetBy: 10)
        
        language.text = lang
        language.textColor = ColorDictionary().getColor(language: lang)
    }
    
    func readMeDownload(){
        let url = data.data["url"] as! String + "/readme"
        GithubAPI().git.get(full_path: url, completion: {(response, error) in
            if let response = response{
                self.rmData = Contents(response.toJson())
                DispatchQueue.main.async {
                    self.drawContent(self.rmData.get("content") as! String)
                }
            } else{
                print(error ?? "")
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! RepoContentViewController
        let user = data.get("owner") as! JSON
        vc.path = (user["login"] as! String) + "/" + (data.get("name") as! String) + "/contents/"
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
        readMe.text = str.decodeBase64()
        scroll.contentSize = readMe.intrinsicContentSize
    }
    
    func setData(_ data :Repository){
        self.data = data
    }
}
