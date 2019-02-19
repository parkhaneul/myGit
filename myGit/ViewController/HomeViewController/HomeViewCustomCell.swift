//
//  HomeViewCustomCell.swift
//  myGit
//
//  Created by 박하늘 on 16/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

struct HomeViewCustomCellModel{
    enum ownerShip : String{
        case owner = "Owner"
        case starred = "Starred"
        case forks = "Forks"
        
        func express() -> (String,UIColor){
            var color : UIColor = UIColor.black
            switch self {
                case .owner : color = UIColor.gray
                case .starred : color = UIColor.blue
                case .forks : color = UIColor.green
            }
            return (self.rawValue,color)
        }
    }
    
    var owner : ownerShip?
    var data : Repository?
}

class HomeViewCustomCell : UITableViewCell{
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var mainText: UILabel!
    @IBOutlet weak var dateText: UILabel!
    @IBOutlet weak var state: UILabel!

    var viewModel = HomeViewCustomCellModel()
    
    func setData(_ repo : Repository){
        viewModel.data = repo
        nameText.text = viewModel.data!.full_name
        mainText.text = viewModel.data!.decription ?? ""
        dateText.text = viewModel.data!.updated_at?.dateCalcul()
        profileImage.downloaded(from: viewModel.data!.owner!.avatar_url!)
        profileImage.circularImage()
        let owner = viewModel.owner?.express()
        state.text = owner?.0
        state.textColor = owner?.1
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


