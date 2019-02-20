//
//  DetailIssueViewController.swift
//  myGit
//
//  Created by 박하늘 on 28/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit
import RxSwift

class DetailIssueViewController : UITableViewController{
    
    @IBOutlet weak var repoText: UILabel!
    @IBOutlet weak var numberText: UILabel!
    @IBOutlet weak var commentText: UILabel!
    @IBOutlet weak var infoText: UILabel!
    @IBOutlet weak var stateText: UILabel!
    
    var data : [Comment]?
    var issue : Issues?
    let disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSpinner(onView: self.view)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        drawInfo()
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        data = nil
        super.viewDidAppear(animated)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailIssue", for: indexPath) as? DetailIssueViewCell
        if data != nil{
            if indexPath.row < data!.count {
                cell?.setData(comments: data![indexPath.row])
            }
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
        let user = issue!.user!
        let userName = user.login!
        let state = issue!.state!
        let created_at = issue!.created_at!.splitToOffset(offsetBy: 10)
        let repo = issue!.repository!
        let repoName = repo.name!
        let number = issue!.number!
        
        repoText.text = repoName
        numberText.text = "# " + String(number)
        stateText.text = state
        commentText.text = String(issue!.comments!) + " comments"
        infoText.text = userName + " " + state + "ed this issue at " + created_at
        
        loadComments(userName: userName, repoName : repoName, number: number)
    }
    
    func loadComments(userName : String, repoName : String, number : Int){
        GithubAPI.API.getIssueCommentsByRepoAndNumber(info: (userName,repoName,number))
        .subscribe{
            self.stopSpinner()
            guard
                let comments = $0.element
            else{
                return
            }
            self.data = comments
            self.reloadData()
        }.disposed(by: disposebag)
    }
    
    func reloadData(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
