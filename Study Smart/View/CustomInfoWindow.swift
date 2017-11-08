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
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        backgroundColor = Color.blue.base
        
        NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        
        layout(label).size(CGSize(width: 50, height: 25))
    }
}
