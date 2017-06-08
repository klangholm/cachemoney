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
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    var wasTrue: Bool = false
    var tapAction1: ((UITableViewCell) -> Void)?
    var tapAction2: ((UITableViewCell) -> Void)?
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //if wasTrue == true {
         //   self.backgroundColor = UIColor.white
            //button.backgroundColor = UIColor.gray
         //   button.backgroundColor = UIColor.white
         //   button.isEnabled = false
//            button.set
          //  UIView.animate(withDuration: 0.5, animations: {
           //     self.button.alpha = 0.2
                //self.alpha = 0.5
           // })
            
        //    wasTrue = false
        //}
        //else if wasTrue == false || selected == true {
         //   self.backgroundColor = UIColor.lightGray
         //   button.backgroundColor = UIColor.lightGray
         //   button.isEnabled = true;

          //  UIView.animate(withDuration: 0.5, animations: {
          //      self.button.alpha = 1
           // })
           // wasTrue = true;
       // }
        
        // Configure the view for the selected state
    }
    
    
    
    func configureCell(meetup: MeetUp) {
        
        ProfPicView.image = meetup.getSender.getPic
        self.ProfPicView.layer.cornerRadius = 0.5 * self.ProfPicView.bounds.size.width
        self.ProfPicView.clipsToBounds = true
        self.ProfPicView.layer.borderWidth = 3.0
        self.ProfPicView.layer.borderColor = UIColor.lightGray.cgColor
        self.nameField.text = meetup.getSender.getName
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/mm/yyyy"
        let newDate = dateFormatter.string(from: meetup.getDate)
        self.timeField.text = newDate + " " + meetup.getTime
        self.placeField.text = meetup.getVenue
        
        
//        button.backgroundColor = UIColor.gray
//        button.isEnabled = false;
        
        
    }
    
    @IBAction func acceptButtonTapped(_ sender: Any) {
        tapAction1?(self)
        acceptButton.isHidden = true
        rejectButton.isHidden = true
    }
    @IBAction func rejectButtonTapped(_ sender: Any) {
        tapAction2?(self)
        acceptButton.isHidden = true
        rejectButton.isHidden = true
    }

    
}
