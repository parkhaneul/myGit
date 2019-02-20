//
//  File.swift
//  myGit
//
//  Created by 박하늘 on 07/02/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit
import RxSwift

class FollowersViewController : UITableViewController{
    var data : [Owner]? = []
    var userData : [Owner] = []
    let disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadFollowers()
        super.viewWillAppear(animated)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowerCell", for: indexPath) as? FollowersViewCell
        if indexPath.row < userData.count {
            cell?.setData(userData[indexPath.row])
        }
        return cell!
    }
    
    func loadFollowers(){
        showSpinner(onView: self.view)
        GithubAPI.API.getFollowers()
            .subscribe{
                guard
                    let followers = $0.element
                    else{
                        self.stopSpinner()
                        return
                }
                self.data = followers
                for user in followers{
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
