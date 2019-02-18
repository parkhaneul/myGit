//
//  FirstViewController.swift
//  myGit
//
//  Created by 박하늘 on 14/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

class HomeViewController : UITableViewController{
    var data : [Repository]?{
        get{
            var data = (ownerData ?? []) + (starredData ?? [])
            data = Array(Set(data))
            data.sort(by: {$0.updated_at! > $1.updated_at!})
            return data
        }
    }
    var ownerData : [Repository]?
    var starredData : [Repository]?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showSpinner(onView: self.view)
        loadUserRepos{
            self.loadStarRepos()
        }
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        tableView.reloadData()
        super.viewDidDisappear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detail = segue.destination as? HomeDetailViewController{
            let cell = sender as! HomeViewCustomCell
            detail.setData(cell.data!)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath) as? HomeViewCustomCell
        if data != nil{
            if indexPath.row < data!.count {
                if ownerData?.contains(data![indexPath.row]) ?? false{
                    cell?.setState(owner: .owner)
                } else{
                    cell?.setState(owner: .starred)
                }
                cell?.setData(data![indexPath.row])
            }
        }
        return cell!
    }
    
    func loadUserRepos(_ completion : @escaping () -> ()){
        GithubAPI().getUserReposByToken { (repoList) in
            if let repoList = repoList{
                self.ownerData = repoList
            }
            completion()
        }
    }
    
    func loadStarRepos(){
        GithubAPI().getUserStarred { (repoList) in
            if let repoList = repoList{
                self.starredData = repoList
            }
            self.stopSpinner()
            self.reloadData()
        }
    }
    
    func reloadData(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
