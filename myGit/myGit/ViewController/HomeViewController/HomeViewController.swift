//
//  FirstViewController.swift
//  myGit
//
//  Created by 박하늘 on 14/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

class HomeViewController : UITableViewController{
    var repoData : [UsersRepos] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? HomeViewCustomCell
        
        print("hey")
        if indexPath.row > 0{
            let repo = repoData[indexPath.row]
            if let user = repo.data["owner"]{
                let user = user as! Owner
                cell?.userName.text = user.data["login"] as? String
            }
        }
        return cell!
    }
    
    func loadData(){
        GithubAPI(authentication : authentication).getUserReposByToken(completion: {(response, error) in
            if let response = response{
                let data = try! JSONSerialization.jsonObject(with: response, options: .mutableContainers) as! [Dictionary<String,Any>]
                for repos in data{
                    self.repoData.append(UsersRepos(json: repos))
                }
            } else{
                print(error ?? "")
            }
        })
    }
}
