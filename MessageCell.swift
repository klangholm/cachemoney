//
//  MessageCell.swift
//  
//
//  Created by Yiheyis, Leoul on 6/7/17.
//
//

import UIKit

class MessageCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var PlaceField: UITextField!
    @IBOutlet weak var TimeField: UITextField!
    @IBOutlet weak var ProfPicView: UIImageView!
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected == true {
            self.backgroundColor = UIColor .blue
            
        }
        
        // Configure the view for the selected state
    }
    
    func configureCell(meetup: MeetUp) {
        ProfPicView.image = profile.getPic
        self.ProfPicView.layer.cornerRadius = 0.5 * self.ProfPicView.bounds.size.width
        self.ProfPicView.clipsToBounds = true
        self.name.text = profile.getName
    }
    
    
    button.setTitleColor(UIColor.grayColor(), forState: .Disabled)
}
