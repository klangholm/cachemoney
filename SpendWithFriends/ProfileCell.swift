//
//  ProfileCell.swift
//  SpendWithFriends
//
//  Created by Kristian Langholm on 6/7/17.
//  Copyright © 2017 klangholm. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var weekday: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(profile: Profile){
        profilePic.image = profile.getPic
        self.profilePic.layer.cornerRadius = 0.5 * self.profilePic.bounds.size.width
        self.profilePic.clipsToBounds = true
        self.name.text = profile.getName
        //set day of the week - figure out how to do that
    }
    
}