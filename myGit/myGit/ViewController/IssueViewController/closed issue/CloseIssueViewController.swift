//
//  CloseIssueViewController.swift
//  myGit
//
//  Created by 박하늘 on 26/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

class CloseIssueViewController : UITableViewController{
    var data : [Issues] = []
    var repos : [Repository] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadIssue()
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        data.removeAll()
        repos.removeAll()
        super.viewDidDisappear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ClosedIssueDetail"{
            let detail = segue.destination as! DetailIssueViewController
            detail.setInfo((sender as! ClosedIssueViewCustomCell).data)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IssueCell2", for: indexPath) as? ClosedIssueViewCustomCell
        
        if indexPath.row < data.count{
            cell?.setData(data[indexPath.row])
        }
        return cell!
    }
    
    func loadIssue(){
        GithubAPI().getClosedIssueByToken(completion: {(response, error) in
            if let response = response{
                for json in response.toJsonArray(){
                    let issue = Issues(json)
                    self.data.append(issue)
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
