//
//  RepoContentsViewController.swift
//  myGit
//
//  Created by 박하늘 on 25/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

class RepoContentViewController : UITableViewController{
    var data : [Contents]? = nil
    var path : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readContents()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        data?.removeAll()
        super.viewDidDisappear(animated)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dir = segue.destination as? RepoContentViewController{
            let send = sender as! DirectoryCell
            dir.path = send.path + send.contentsName.text! + "/"
        }
        
        if let dir = segue.destination as? FileDetailViewController{
            let send = sender as! FileCell
            dir.path = send.path + send.contentsName.text! + "/"
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if data != nil{
            if(indexPath.row < data!.count + 1){
                let content = data![indexPath.row]
                if(content.type == "file"){
                    let cell = tableView.dequeueReusableCell(withIdentifier: "file", for: indexPath) as! FileCell
                    cell.setData(content)
                    cell.setPath(self.path)
                    return cell
                } else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "directory", for: indexPath) as! DirectoryCell
                    cell.setData(content)
                    cell.setPath(self.path)
                    return cell
                }
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "file", for: indexPath) as! FileCell
                return cell
            }
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "file", for: indexPath) as! FileCell
            return cell
        }
    }
    
    func readContents(){
        showSpinner(onView: self.view)
        GithubAPI().getContentsByPath(path: path, completion: {(content) in
            if let content = content{
                self.data = content
                self.reloadData()
            }
            self.stopSpinner()
        })
    }
    
    func reloadData(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
