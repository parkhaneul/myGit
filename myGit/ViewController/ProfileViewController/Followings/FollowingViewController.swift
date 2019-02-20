//
//  FollowingViewController.swift
//  myGit
//
//  Created by 박하늘 on 07/02/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit
import RxSwift

class FollowingViewController : UITableViewController{
    var data : [Owner]? = []
    var userData : [Owner] = []
    let disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadFollowing()
        super.viewWillAppear(animated)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowingCell", for: indexPath) as? FollowingViewCell
        if indexPath.row < userData.count{
            cell?.setData(userData[indexPath.row])
        }
        return cell!
    }
    
    func loadFollowing(){
        showSpinner(onView: self.view)
        GithubAPI.API.getFollowing()
        .subscribe{
            guard
                let following = $0.element
            else{
                self.stopSpinner()
                return
            }
            self.data = following
            for user in following{
                self.loadUser(login: user.login!)
            }
        }.disposed(by: disposebag)
    }
    
    func loadUser(login : String){
        GithubAPI.API.getUserByLoginString(login)
        .subscribe{
            self.stopSpinner()
            guard
                let user = $0.element
            else{
                return
            }
            self.userData.append(user)
            self.reloadData()
        }.disposed(by: disposebag)
    }
    
    func reloadData(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
