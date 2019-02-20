//
//  FirstViewController.swift
//  myGit
//
//  Created by 박하늘 on 14/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit
import RxSwift

struct HomeViewControllerModel{
    var data : [Repository]{
        get{
            var data = ownerData + starredData
            data = Array(Set(data))
            data.sort(by: {$0.updated_at! > $1.updated_at!})
            return data
        }
    }
    let ownerData : [Repository]
    let starredData : [Repository]
}

class HomeViewController : UITableViewController{
    var viewModel : HomeViewControllerModel?
    let disposebag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showSpinner(onView: self.view)
        loadUserRepos()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detail = segue.destination as? HomeDetailViewController{
            let cell = sender as! HomeViewCustomCell
            detail.setData(cell.viewModel!.data)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.data.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath) as? HomeViewCustomCell
        if let viewModel = viewModel{
            var ownerShip = HomeViewCustomCellModel.ownerShip.owner
            if indexPath.row < viewModel.data.count {
                if viewModel.ownerData.contains(viewModel.data[indexPath.row]){
                    ownerShip = .owner
                } else{
                    ownerShip = .starred
                }
                cell?.setData(viewModel.data[indexPath.row],ownerShip: ownerShip)
            }
        }
        return cell!
    }
    
    func loadUserRepos(){
        GithubAPI.API.getUserReposByToken()
        .subscribe{
            guard
                let repoList = $0.element
            else{
                return
            }
            self.loadStarRepos(repoList)
        }.disposed(by: disposebag)
    }
    
    func loadStarRepos(_ ownerList : [Repository]){
        GithubAPI.API.getUserStarred()
            .subscribe{
                guard
                    let repoList = $0.element
                    else{
                        return
                }
                self.viewModel = HomeViewControllerModel(ownerData: ownerList, starredData: repoList)
                self.reloadData()
                self.stopSpinner()
            }.disposed(by: disposebag)
    }
    
    func reloadData(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
