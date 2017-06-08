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
    
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var placeField: UILabel!
    @IBOutlet weak var timeField: UILabel!
    
   
    @IBOutlet weak var ProfPicView: UIImageView!
    @IBOutlet weak var button: UIButton!
    var wasTrue: Bool = false
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        if wasTrue == true {
            self.backgroundColor = UIColor.white
            button.backgroundColor = UIColor.gray
            button.isEnabled = false
            wasTrue = false
        }
        else if wasTrue == false || selected == true {
            self.backgroundColor = UIColor.gray
            button.backgroundColor = UIColor.white
            button.isEnabled = true;
            wasTrue = true;
        }
//        else {
//           // selected = false
//            self.backgroundColor = UIColor.white
//            button.backgroundColor = UIColor.gray
//            button.isEnabled = false
//        }
//        
        // Configure the view for the selected state
    }
    
    
    
    func configureCell(meetup: MeetUp) {
        
        ProfPicView.image = meetup.getSender.getPic
        self.ProfPicView.layer.cornerRadius = 0.5 * self.ProfPicView.bounds.size.width
        self.ProfPicView.clipsToBounds = true
        self.nameField.text = meetup.getSender.getName
        self.timeField.text = meetup.getTime
        self.placeField.text = meetup.getVenue
        
        
//        button.backgroundColor = UIColor.gray
//        button.isEnabled = false;
        
        
    }
    
    
    
}
