//
//  HomeDetailViewController.swift
//  myGit
//
//  Created by 박하늘 on 23/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

class HomeDetailViewController : UIViewController{
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var gitName: UILabel!
    @IBOutlet weak var created_at: UILabel!
    @IBOutlet weak var lastest_commit_at: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var readMe: UILabel!
    
    var data : Repository = Repository([:])
    var rmData : ReadMe = ReadMe([:])
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        readMeDownload()
        let user = data.data["owner"] as! JSON
        userName.text = user["login"] as! String
        gitName.text = "/" + (data.data["name"] as! String)
        let created = data.data["created_at"] as! String
        created_at.text = "Created at " + created.splitToOffset(offsetBy: 10)
        let updated = data.data["updated_at"] as! String
        lastest_commit_at.text = "Lastest update at " + updated.splitToOffset(offsetBy: 10)
        let lang = data.data["language"] as? String
        language.text = lang
        language.textColor = ColorDictionary().getColor(language: lang)
        super.viewWillAppear(animated)
    }
    
    func readMeDownload(){
        let url = data.data["url"] as! String + "/readme"
        GithubAPI(authentication : authentication).get(full_path: url, completion: {(response, error) in
            if let response = response{
                let data = try! JSONSerialization.jsonObject(with: response, options: .mutableContainers) as! JSON
                self.rmData = ReadMe(data)
                DispatchQueue.main.async {
                    let read = self.rmData.data["content"] as! String
                    print(read)
                    self.readMe.text = self.decode(base64String: read)
                }
            } else{
                print(error ?? "")
            }
        })
    }
    
    func decode(base64String : String) -> String?{
        guard let decodedData = Data(base64Encoded: base64String) else {
            return nil
        }
        return String(data: decodedData, encoding: .utf8)!
    }
    
    func setData(_ data :Repository){
        self.data = data
    }
}
