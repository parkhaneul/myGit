//
//  FirstViewController.swift
//  myGit
//
//  Created by 박하늘 on 14/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

struct HomeViewControllerModel{
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
}

class HomeViewController : UITableViewController{
    var viewModel = HomeViewControllerModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showSpinner(onView: self.view)
        loadUserRepos{
            self.loadStarRepos()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detail = segue.destination as? HomeDetailViewController{
            let cell = sender as! HomeViewCustomCell
            detail.setData(cell.viewModel.data!)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath) as? HomeViewCustomCell
        if viewModel.data != nil{
            if indexPath.row < viewModel.data!.count {
                if viewModel.ownerData?.contains(viewModel.data![indexPath.row]) ?? false{
                    cell?.viewModel.owner = .owner
                } else{
                    cell?.viewModel.owner = .starred
                }
                cell?.setData(viewModel.data![indexPath.row])
            }
        }
        return cell!
    }
    
    func loadUserRepos(_ completion : @escaping () -> ()){
        GithubAPI().getUserReposByToken { (repoList) in
            if let repoList = repoList{
                self.viewModel.ownerData = repoList
            }
            completion()
        }
    }
    
    func loadStarRepos(){
        GithubAPI().getUserStarred { (repoList) in
            if let repoList = repoList{
                self.viewModel.starredData = repoList
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
