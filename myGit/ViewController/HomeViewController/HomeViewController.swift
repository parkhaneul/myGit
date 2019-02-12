//
//  FirstViewController.swift
//  myGit
//
//  Created by 박하늘 on 14/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

class HomeViewController : UITableViewController{
    var data : [Repository] = []
    var orgs : [Organization] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showSpinner(onView: self.view)
        loadUserRepos{
            self.loadStarRepos()
        }
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        data.removeAll()
        orgs.removeAll()
        tableView.reloadData()
        super.viewDidDisappear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detail = segue.destination as? HomeDetailViewController{
            let cell = sender as! HomeViewCustomCell
            detail.setData(cell.data)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath) as? HomeViewCustomCell
        
        if indexPath.row < data.count {
            cell?.setData(data[indexPath.row])
        }
        return cell!
    }
    
    func loadUserRepos(_ completion : @escaping () -> ()){
        GithubAPI().getUserReposByToken(completion: {(response, error) in
            if let response = response{
                for repos in response.toJsonArray(){
                    self.data.append(Repository(repos))
                }
                completion()
            } else{
                ConnectFailViewController.showErrorView(self)
            }
        })
    }
    
    func loadStarRepos(){
        GithubAPI().getUserStarred(completion: {(response, error) in
            self.stopSpinner()
            if let response = response{
                for json in response.toJsonArray(){
                    var repository = Repository(json)
                    var flag : Bool = true
                    for repo in self.data{
                        if (repo.get("id") as! Int) == (repository.get("id") as! Int){
                            flag = false
                        }
                    }
                    if flag{
                        repository.data["state"] = "Starred"
                        self.data.append(repository)
                    }
                }
                self.data.sort(by : {
                    $0.data["updated_at"] as! String > $1.data["updated_at"] as! String
                })
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else{
                ConnectFailViewController.showErrorView(self)
            }
        })
    }
    
    func loadOrgs(){
        GithubAPI().getUserOrg { (response, error) in
            if let response = response{
                for json in response.toJsonArray(){
                    let org = Organization(json)
                    self.orgs.append(org)
                }
                for org in self.orgs{
                    self.loadForkRepos(organization: org.get("login") as! String)
                }
                self.data.sort(by : {
                    $0.data["updated_at"] as! String > $1.data["updated_at"] as! String
                })
                DispatchQueue.main.async {
                    self.stopSpinner()
                    self.tableView.reloadData()
                }
            } else{
                ConnectFailViewController.showErrorView(self)
            }
        }
    }
    
    func loadForkRepos(organization : String){
        GithubAPI().getOrgFork(org : organization, completion: {(response, error) in
            if let response = response{
                for json in response.toJsonArray(){
                    var repo = Repository(json)
                    repo.data["state"] = "Forks"
                    self.data.append(repo)
                }
            } else{
                ConnectFailViewController.showErrorView(self)
            }
        })
    }
}
