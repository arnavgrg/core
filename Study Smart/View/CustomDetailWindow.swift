//
//  CustomDetailWindow.swift
//  Study Smart
//
//  Created by Parth Pendurkar on 11/7/17.
//  Copyright © 2017 UCLA DevX. All rights reserved.
//

import UIKit
import Material

class CustomDetailWindow: UIView
{
    var label: UILabel!
    var exitButton: FlatButton!
    //TODO: Add other fields such as percentage fill, etc
    
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
        setupLabel()
        setupExitButton()
    }
}

extension CustomDetailWindow
{
    func setupLabel()
    {
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        backgroundColor = Color.lightBlue.base
        
        NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        
        layout(label).size(CGSize(width: 50, height: 25))
    }
    
    func setupExitButton()
    {
        exitButton = FlatButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(exitButton)
        
        exitButton.addTarget(self, action: #selector(hide), for: .touchUpInside)
        exitButton.setTitle("Exit", for: .normal)
        
        NSLayoutConstraint(item: exitButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: exitButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: -50).isActive = true
        
        layout(exitButton).size(CGSize(width: 100, height: 50))
    }
}

@objc
extension CustomDetailWindow
{
    func hide()
    {
        isHidden = true
    }
}
