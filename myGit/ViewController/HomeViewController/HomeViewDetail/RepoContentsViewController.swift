//
//  RepoContentsViewController.swift
//  myGit
//
//  Created by 박하늘 on 25/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

struct RepoContentViewControllerModel{
    var data : [Contents]?
    var path : String = ""
}

class RepoContentViewController : UITableViewController{
    var viewModel = RepoContentViewControllerModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readContents()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data?.count ?? 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dir = segue.destination as? RepoContentViewController{
            let send = sender as! DirectoryCell
            dir.viewModel.path = send.path + send.contentsName.text! + "/"
        }
        
        if let dir = segue.destination as? FileDetailViewController{
            let send = sender as! FileCell
            dir.viewModel.path = send.path + send.contentsName.text! + "/"
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row < viewModel.data!.count + 1){
                let content = viewModel.data![indexPath.row]
                if(content.type == "file"){
                    let cell = tableView.dequeueReusableCell(withIdentifier: "file", for: indexPath) as! FileCell
                    cell.setData(content)
                    cell.setPath(viewModel.path)
                    return cell
                } else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "directory", for: indexPath) as! DirectoryCell
                    cell.setData(content)
                    cell.setPath(viewModel.path)
                    return cell
                }
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "file", for: indexPath) as! FileCell
                return cell
            }
        }
    
    func readContents(){
        showSpinner(onView: self.view)
        GithubAPI().getContentsByPath(path: viewModel.path, completion: {(content) in
            if let content = content{
                self.viewModel.data = content
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
