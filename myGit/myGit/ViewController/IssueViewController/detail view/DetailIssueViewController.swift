//
//  DetailIssueViewController.swift
//  myGit
//
//  Created by 박하늘 on 28/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

class DetailIssueViewController : UITableViewController{
    
    @IBOutlet weak var repoText: UILabel!
    @IBOutlet weak var numberText: UILabel!
    @IBOutlet weak var commentText: UILabel!
    @IBOutlet weak var infoText: UILabel!
    @IBOutlet weak var stateText: UILabel!
    
    var data : [Comment] = []
    var issue : Issues = Issues([:])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        drawInfo()
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        data.removeAll()
        super.viewDidAppear(animated)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailIssue", for: indexPath) as? DetailIssueViewCell
        if indexPath.row + 1 < data.count {
            let user = data[indexPath.row].get("user") as! JSON
            cell?.usernameText.text = user["login"] as! String
            cell?.commentDate.text = "comments at " + (data[indexPath.row].get("created_at") as! String).splitToOffset(offsetBy: 10)
            cell?.commentText.text = data[indexPath.row].get("body") as! String
            cell?.draw()
        }
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? DetailIssueViewCell
        cell?.autoScroll()
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? DetailIssueViewCell
        cell?.deSelected()
    }
    
    func setInfo(_ issue : Issues){
        self.issue = issue
    }
    
    func drawInfo(){
        let userName : String = Owner(issue.get("user") as! JSON).get("login") as! String
        let state : String = issue.get("state") as! String
        let created_at : String = (issue.get("created_at") as! String).splitToOffset(offsetBy: 10)
        let repo = issue.get("repository") as! JSON
        let repoName : String = repo["name"] as! String
        let number : Int = issue.get("number") as! Int
        
        repoText.text = repoName
        numberText.text = "# " + String(number)
        stateText.text = state
        commentText.text = String(issue.get("comments") as! Int) + " comments"
        
        infoText.text = userName + " " + state + "ed this issue at " + created_at
        loadComments(userName: userName, repoName : repoName, number: number)
    }
    
    func loadComments(userName : String, repoName : String, number : Int){
        GithubAPI().getIssueCommentsByRepoAndNumber(info: (userName,repoName,number), completion: {(response, error) in
            if let response = response{
                for json in response.toJsonArray(){
                    let comment = Comment(json)
                    self.data.append(comment)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else{
                print(error ?? "")
            }
        })
    }
}
