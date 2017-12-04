//
//  LoadingView.swift
//  Study Smart
//
//  Created by Parth Pendurkar on 12/4/17.
//  Copyright © 2017 UCLA DevX. All rights reserved.
//

import Foundation
import UIKit
import Material

class LoadingView: UIView
{
    var loadingLabel: UILabel!
    
    //var hoursView: UIView!
    
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
        setupBackground()
        setupLabel()
    }
}

extension LoadingView
{
    func setupBackground()
    {
        self.backgroundColor = Color.green.lighten3
    }
    
    func setupLabel()
    {
        loadingLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        loadingLabel.font = UIFont(name: "Avenir-Heavy", size: 20)
        loadingLabel.textColor = UIColor.white
        loadingLabel.textAlignment = .center
        addSubview(loadingLabel)
        
        loadingLabel.numberOfLines = 0
        loadingLabel.text = "Loading..."
        loadingLabel.adjustsFontSizeToFitWidth = true
        NSLayoutConstraint(item: loadingLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: loadingLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        layout(loadingLabel).size(CGSize(width: 250, height: 25))
    }
}
