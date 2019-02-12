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
    var repos : [Repository] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGesture(.left)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if data.isEmpty {
            loadIssue()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        data.removeAll()
        repos.removeAll()
        tableView.reloadData()
        super.viewDidDisappear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "IssueDetail"{
            let detail = segue.destination as! DetailIssueViewController
            detail.setInfo((sender as! IssueViewCustomCell).data)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IssueCell", for: indexPath) as? IssueViewCustomCell
        if indexPath.row < data.count + 1{
            cell?.setData(data[indexPath.row])
        }
        return cell!
    }
    
    func setGesture(_ direction : UISwipeGestureRecognizer.Direction){
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture: )))
        swipe.direction = direction
        self.view.addGestureRecognizer(swipe)
    }
    
    @objc func handleGesture(gesture : UISwipeGestureRecognizer){
        if gesture.direction == UISwipeGestureRecognizer.Direction.left{
            self.performSegue(withIdentifier: "closeIssue", sender: self)
        }
    }
    
    func loadIssue(){
        showSpinner(onView: self.view)
        GithubAPI().getIssueByToken(completion: {(response, error) in
            self.stopSpinner()
            if let response = response{
                for json in response.toJsonArray(){
                    let issue = Issues(json)
                    self.data.append(issue)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else{
                ConnectFailViewController.showErrorView(self)
            }
        })
    }
}
