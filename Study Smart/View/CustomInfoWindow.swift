//
//  CustomInfoView.swift
//  Study Smart
//
//  Created by Anton Lykov on 11/4/17.
//  Copyright © 2017 UCLA DevX. All rights reserved.
//

import UIKit
import Material

class CustomInfoWindow: UIView
{

    var label: UILabel!
    var businessLabel: UILabel!
    var hoursLabel: UILabel!
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView()
    {
        setupBackground()
        setupLabel()
        setupBusinessLabel()
        setupHoursLabel()
    }
}

extension CustomInfoWindow
{
    func setupBackground(){
        let imageView = UIImageView(image: UIImage(named: "InfoWindow"))
        self.addSubview(imageView)
        self.cornerRadiusPreset = .cornerRadius3
        sendSubview(toBack: imageView)
    }
    
    func setupLabel()
    {
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.font = UIFont(name: "Avenir Black", size: 14.0)
        addSubview(label)
        
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        //NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 5).isActive = true
        
        layout(label).size(CGSize(width: 175, height: 25))
    }
    
    func setupBusinessLabel()
    {
        businessLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        businessLabel.translatesAutoresizingMaskIntoConstraints = false
        //label.font = UIFont(name: "Avenir Black", size: 14.0)
        addSubview(businessLabel)
        
        businessLabel.numberOfLines = 1
        businessLabel.adjustsFontSizeToFitWidth = false
        //NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        businessLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        NSLayoutConstraint(item: businessLabel, attribute: .top, relatedBy: .equal, toItem: label, attribute: .bottom, multiplier: 1.0, constant: 5).isActive = true
        
        layout(businessLabel).size(CGSize(width: 175, height: 25))
    }
    
    func setupHoursLabel()
    {
        hoursLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        hoursLabel.translatesAutoresizingMaskIntoConstraints = false
        //label.font = UIFont(name: "Avenir Black", size: 14.0)
        addSubview(hoursLabel)
        
        hoursLabel.numberOfLines = 1
        hoursLabel.adjustsFontSizeToFitWidth = false
        //NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        hoursLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        NSLayoutConstraint(item: hoursLabel, attribute: .top, relatedBy: .equal, toItem: businessLabel, attribute: .bottom, multiplier: 1.0, constant: 5).isActive = true
        
        layout(hoursLabel).size(CGSize(width: 175, height: 25))
    }

}
