//
//  RepoContentsViewController.swift
//  myGit
//
//  Created by 박하늘 on 25/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

class RepoContentViewController : UITableViewController{
    var data : [Contents] = []
    var path : String = ""
    var isEmpty : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readContents()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        data.removeAll()
        super.viewDidDisappear(animated)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
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
        var cell : UITableViewCell?
        if(indexPath.row < data.count && indexPath.row >= 0){
            let content = data[indexPath.row]
            if((content.get("type") as! String) == "file"){
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
        }
        return cell!
    }
    
    func readContents(){
        showSpinner(onView: self.view)
        GithubAPI().getFileByPath(path: path, completion: {(response, error) in
            self.stopSpinner()
            if let response = response{
                if self.isEmpty {
                }else{
                    for content in response.toJsonArray(){
                        self.data.append(Contents(content))
                    }
                    self.data.sort(by : {
                        $1.data["type"] as! String > $0.data["type"] as! String
                    })
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            } else{
                ConnectFailViewController.showErrorView(self)
            }
        })
    }
}
