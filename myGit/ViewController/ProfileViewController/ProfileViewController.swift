//
//  ProfileViewController.swift
//  myGit
//
//  Created by 박하늘 on 16/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//
import UIKit
import RxSwift

class ProfileViewController : UITableViewController{
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var followings: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    var user : Owner? = nil
    let disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData(){
        showSpinner(onView: self.view)
        GithubAPI.API.getUserByToken()
        .subscribe{
            self.stopSpinner()
            guard
                let user = $0.element
            else{
                return
            }
            self.user = user
            self.reloadData()
        }.disposed(by: disposebag)
    }
    
    func updateUserInfo(){
        self.profileImage.downloaded(from: user!.avatar_url!)
        self.profileImage.circularImage()
        self.profileImage.setBorder(width: 2, color: UIColor.white.cgColor)
        self.name.text = user!.name!
        self.fullName.text = user!.company ?? ""
        self.followers.text = "followers" + String(user!.followers!)
        self.followings.text = "following" + String(user!.following!)
    }
    
    func reloadData(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.updateUserInfo()
        }
    }
}
