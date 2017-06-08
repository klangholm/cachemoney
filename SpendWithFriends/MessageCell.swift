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
    @IBOutlet weak var button: UIButton!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected == true {
            self.backgroundColor = UIColor .blue
            button.backgroundColor = UIColor.white
            button.isEnabled = true;
        }
        
        // Configure the view for the selected state
    }
    
    func configureCell(meetup: MeetUp) {
        ProfPicView.image = meetup.getSender.getPic
        self.ProfPicView.layer.cornerRadius = 0.5 * self.ProfPicView.bounds.size.width
        self.ProfPicView.clipsToBounds = true
        self.NameField.text = meetup.getSender.getName
        self.TimeField.text = meetup.getTime
        self.PlaceField.text = meetup.getVenue
        
        
        button.backgroundColor = UIColor.gray
        button.isEnabled = false;
        
        
    }
    
    
    
}
