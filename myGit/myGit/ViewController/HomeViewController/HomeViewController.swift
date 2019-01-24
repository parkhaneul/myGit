//
//  FirstViewController.swift
//  myGit
//
//  Created by 박하늘 on 14/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

class HomeViewController : UITableViewController{
    var repoData : [Repository] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        repoData = []
        GithubAPI(authentication : authentication).getUserReposByToken(completion: {(response, error) in
            if let response = response{
                let data = try! JSONSerialization.jsonObject(with: response, options: .mutableContainers) as! [JSON]
                for repos in data{
                    self.repoData.append(Repository(repos))
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else{
                print(error ?? "")
            }
        })
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("it works")
        var names : [String] = []
        for repos in repoData{
            names.append(repos.data["name"] as! String)
        }
        shared.setData(key: "ReposName", values: names)
        super.viewDidAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detail = segue.destination as! HomeDetailViewController
        let cell = sender as! HomeViewCustomCell
        detail.setData(cell.data)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath) as? HomeViewCustomCell
        
        if(indexPath.row <= repoData.count){
            let repo = repoData[indexPath.row]
            if let user = repo.data["owner"]{
                let user = Owner(user as! JSON)
                cell?.profileImage.downloaded(from: user.data["avatar_url"] as! String)
                cell?.profileImage.circularImage()
            }
            cell?.nameText.text = repo.data["full_name"] as? String
            cell?.mainText.text = repo.data["description"] as? String
            let date = repo.data["created_at"] as! String
            cell?.dateText.text = date.splitToOffset(offsetBy: 10)
            cell?.data = repo
        }
        return cell!
    }
}
