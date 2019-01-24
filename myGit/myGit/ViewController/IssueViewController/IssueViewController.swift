//
//  SecondViewController.swift
//  myGit
//
//  Created by 박하늘 on 14/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

class IssueViewController : UITableViewController {
    var data : [Issues] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        data = []
        let repos = shared.getData(key: "ReposName") as! [String]
        for repo in repos{
            GithubAPI(authentication : authentication).getUserIssuesByRepos(repos: repo, completion: {(response, error) in
                if let response = response{
                    var data = try! JSONSerialization.jsonObject(with: response, options: .mutableContainers) as! [JSON]
                    for json in data{
                        var issue = Issues(json)
                        issue.data["repoName"] = repo
                        self.data.append(issue)
                    }
                } else{
                    print(error ?? "")
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }
        super.viewWillAppear(animated)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IssueCell", for: indexPath) as? IssueViewCustomCell
        
        cell?.dataText.text = data[indexPath.row].data["title"] as! String
        
        let repoName = data[indexPath.row].data["repoName"] as! String
        let numberInfo = data[indexPath.row].data["number"] as! Int
        let created_date = data[indexPath.row].data["created_at"] as! String
        let dateString = created_date.splitToOffset(offsetBy: 10)
        let user = data[indexPath.row].data["user"] as! JSON
        let userNamae = user["login"] as! String
        
        let infoText = repoName + " #" + numberInfo.description + " opened " + dateString + " by " + userNamae
        cell?.infoText.text = infoText
        
        return cell!
    }
}

extension String{
    func splitToOffset(offsetBy : Int) -> String{
        return String(self[..<self.index(self.startIndex, offsetBy: offsetBy)])
    }
}
