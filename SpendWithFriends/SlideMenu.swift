//
//  SlideMenu.swift
//  SpendWithFriends
//
//  Created by Porupski, Luke on 6/7/17.
//  Copyright © 2017 klangholm. All rights reserved.
//

import Foundation
import UIKit

enum viewState {
    case closed
    case open
}

protocol SlideMenuDelegate {
    func didUpdateViewStatus(toStatus: selectedMode)
}

class SlideMenu: UIView {
    
    //discover , meetups, settings, requests
    
    private var status: viewState = .closed
    private var selectedState: selectedMode = .discover
    var delegate: SlideMenuDelegate?
    
    
    var discoverButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 5, y: 0, width: 110, height: 60))
        button.setTitle("DISCOVER", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica-Neue", size: 40)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(didTapDiscoverButton), for: .touchUpInside)
        return button
    }()
    
    var meetupsButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 5, y: 50, width: 110, height: 60))
        button.setTitle("MEETUPS", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica-Neue", size: 40)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.addTarget(self, action: #selector(didTapMeetupsButton), for: .touchUpInside)
        return button
    }()
    
    var requestsButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 5, y: 100, width: 110, height: 60))
        button.setTitle("REQUESTS", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica-Neue-Bold", size: 40)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.addTarget(self, action: #selector(didTapRequestsButton), for: .touchUpInside)
        return button
    }()
    
    var settingsButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 5, y: 150, width: 110, height: 60))
        button.setTitle("SETTINGS", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica-Neue-Bold", size: 40)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.addTarget(self, action: #selector(didTapSettingsButton), for: .touchUpInside)
        return button
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.backgroundColor = UIColor(colorLiteralRed: 155/255, green: 155/255, blue: 155/255, alpha: 0.7)
        
        
        
        self.addSubview(discoverButton)
        self.addSubview(meetupsButton)
        self.addSubview(requestsButton)
        //self.addSubview(settingsButton)
        
        
    }
    
    
    func toggle() {
        if self.status == .closed {
            status = .open
            UIView.animate(withDuration: 0.3, animations: {
                self.frame.origin.x = 0
            })
            
        }
        else {
            status = .closed
            UIView.animate(withDuration: 0.3, animations: {
                self.frame.origin.x = -140
            })
            
        }
    }
    
    func didTapDiscoverButton(){
        if self.selectedState != .discover {
            
            self.selectedState = .discover
            self.delegate?.didUpdateViewStatus(toStatus: .discover)
            
            UIView.animate(withDuration: 0.3, animations: {
                
                self.meetupsButton.setTitleColor(UIColor.gray, for: .normal)
                self.requestsButton.setTitleColor(UIColor.gray, for: .normal)
                self.settingsButton.setTitleColor(UIColor.gray, for: .normal)
                
                self.discoverButton.setTitleColor(UIColor.white, for: .normal)
                
            })
        }
        self.toggle()
    }
    
    func didTapMeetupsButton(){
        if self.selectedState != .meetups {
            
            self.selectedState = .meetups
            self.delegate?.didUpdateViewStatus(toStatus: .meetups)
            
            self.discoverButton.setTitleColor(UIColor.gray, for: .normal)
            self.requestsButton.setTitleColor(UIColor.gray, for: .normal)
            self.settingsButton.setTitleColor(UIColor.gray, for: .normal)
            
            self.meetupsButton.setTitleColor(UIColor.white, for: .normal)
        }
        self.toggle()
    }
    
    func didTapRequestsButton(){
        if self.selectedState != .requests {
            
            self.selectedState = .requests
            self.delegate?.didUpdateViewStatus(toStatus: .requests)
            
            self.meetupsButton.setTitleColor(UIColor.gray, for: .normal)
            self.discoverButton.setTitleColor(UIColor.gray, for: .normal)
            self.settingsButton.setTitleColor(UIColor.gray, for: .normal)
            
            self.requestsButton.setTitleColor(UIColor.white, for: .normal)
        }
        self.toggle()
    }
    
    func didTapSettingsButton(){
        if self.selectedState != .settings {
            self.selectedState = .settings
            self.delegate?.didUpdateViewStatus(toStatus: .settings)
            
            self.meetupsButton.setTitleColor(UIColor.gray, for: .normal)
            self.requestsButton.setTitleColor(UIColor.gray, for: .normal)
            self.discoverButton.setTitleColor(UIColor.gray, for: .normal)
            
            self.settingsButton.setTitleColor(UIColor.white, for: .normal)
        }
        self.toggle()
    }
    
}
