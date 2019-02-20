//
//  HomeDetailViewController.swift
//  myGit
//
//  Created by 박하늘 on 23/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit
import RxSwift

struct HomeDetailViewControllerModel{
    let data : BehaviorSubject<Repository>
    let rmData : BehaviorSubject<Contents>
}

class HomeDetailViewController : UIViewController{
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var gitName: UILabel!
    @IBOutlet weak var created_at: UILabel!
    @IBOutlet weak var lastest_commit_at: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var readMe: UILabel!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var watch: UILabel!
    @IBOutlet weak var star: UILabel!
    @IBOutlet weak var fork: UILabel!
    
    var viewModel : HomeDetailViewControllerModel?
    let disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGesture(.left)
    }
    
    func draw(_ data : Repository?){
        guard let data = data else{
            return
        }
        self.watch.text = String(data.watchers ?? 0)
        self.star.text = String(data.stargazers_count ?? 0)
        self.fork.text = String(data.forks ?? 0)
        
        self.userName.text = data.owner!.login
        self.gitName.text = "/" + data.name!
        self.created_at.text = "Created at " + data.created_at!.splitToOffset(offsetBy: 10)
        self.lastest_commit_at.text = "Lastest update at " + data.updated_at!.splitToOffset(offsetBy: 10)
        
        self.language.text = data.language
        self.language.textColor = ColorDictionary().getColor(language: data.language)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! RepoContentViewController
        guard let data = try? viewModel!.data.value() else{
            return
        }
        let user = data.owner
        vc.viewModel.path = user!.login! + "/" + data.name! + "/contents/"
    }
    
    func setGesture(_ direction : UISwipeGestureRecognizer.Direction){
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture: )))
        swipe.direction = direction
        self.view.addGestureRecognizer(swipe)
    }
    
    @objc func handleGesture(gesture : UISwipeGestureRecognizer){
        if gesture.direction == UISwipeGestureRecognizer.Direction.left{
            self.performSegue(withIdentifier: "contentSegue", sender: self)
        }
    }
    
    func drawContent(_ contents : Contents?){
        guard let str = contents?.content else{
            return
        }
        self.readMe.text = str.decodeBase64()
        self.scroll.contentSize = self.readMe.intrinsicContentSize
    }
    
    func setData(_ data :Repository){
        showSpinner(onView: self.view)
        let url = data.url! + "/readme"
        GithubAPI.API.getReadMe(full_path: url)
        .subscribe{
            guard
                let readMe = $0.element
            else{
                self.stopSpinner()
                return
            }
            let variableData = BehaviorSubject(value: data)
            let variableReadMe = BehaviorSubject(value: readMe)
            self.viewModel = HomeDetailViewControllerModel(data: variableData, rmData: variableReadMe)
            self.viewModel?.data.asObservable()
            .subscribe{
                self.draw($0.element)
            }.disposed(by: self.disposebag)
            
            self.viewModel?.rmData.asObservable()
            .subscribe{
                self.drawContent($0.element)
            }.disposed(by: self.disposebag)
            self.stopSpinner()
        }.disposed(by: disposebag)
    }
}
