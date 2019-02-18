//
//  CloseIssueViewController.swift
//  myGit
//
//  Created by 박하늘 on 26/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

class CloseIssueViewController : UITableViewController{
    var _data : [Issues]?
    var data : [Issues]?{
        get{
            return _data
        }
        set(newVal){
            _data = newVal
            if newVal != nil{
                self.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if data == nil {
            loadIssue()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        data = nil
        super.viewDidDisappear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ClosedIssueDetail"{
            let detail = segue.destination as! DetailIssueViewController
            detail.setInfo((sender as! ClosedIssueViewCustomCell).data!)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IssueCell2", for: indexPath) as? ClosedIssueViewCustomCell
        if data != nil{
            if indexPath.row < data!.count + 1{
                cell?.setData(data![indexPath.row])
            }
        }
        return cell!
    }
    
    func loadIssue(){
        showSpinner(onView: self.view)
        GithubAPI().getClosedIssueByToken{(issueList) in
            if let issueList = issueList{
                self.data = issueList
            }
            self.stopSpinner()
        }
    }
    
    func reloadData(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
