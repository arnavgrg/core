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
    var newsButton: UIButton!
    var reserveButton: UIButton!
    var infoButton: UIButton!
    
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
        //setupHoursView()
        setupLabel()
        setupExitButton()
        setupOtherButtons()
        //setupHoursView()
    }
}

extension CustomDetailWindow
{
    
    /*func setupHoursView(){
        hoursView = UIView()
        self.addSubview(hoursView)
        hoursView.translatesAutoresizingMaskIntoConstraints = false
        self.bringSubview(toFront: hoursView)
        NSLayoutConstraint(item: hoursView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: hoursView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.25, constant: 0).isActive = true
        NSLayoutConstraint(item: hoursView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.9, constant: 0).isActive = true
        hoursView.backgroundColor = UIColor(red:0.96, green:0.61, blue:0.47, alpha:1.0) //F59C78
        NSLayoutConstraint(item: hoursView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 50).isActive = true
        hoursView.cornerRadiusPreset = .cornerRadius3
        
    }*/
    
    func setupBackground() {
        let imageView = UIImageView(image: UIImage(named: "detailView"))
        self.addSubview(imageView)
        self.cornerRadiusPreset = .cornerRadius3
        imageView.contentMode = .scaleAspectFit
        sendSubview(toBack: imageView)
    }
    
    func setupLabel()
    {
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Heavy", size: 18.0)
        label.textColor = UIColor.white
        addSubview(label)
        
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 25).isActive = true
        layout(label).size(CGSize(width: 200, height: 23))
    }
    
     func setupExitButton()
    {
        exitButton = FlatButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(exitButton)
        
        exitButton.addTarget(self, action: #selector(hide), for: .touchUpInside)
        exitButton.setTitle("Exit", for: .normal)
        exitButton.titleLabel?.font = UIFont(name: "Avenir", size: 18)
        
        NSLayoutConstraint(item: exitButton, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint(item: exitButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 10).isActive = true
        
        layout(exitButton).size(CGSize(width: 50, height: 50))
    }
    
    func setupOtherButtons()
    {
        let newsImage = UIImage(named: "newsButton") as UIImage?
        newsButton = UIButton(type: UIButtonType.custom) as UIButton
        newsButton.frame = CGRect(x: 41, y: 580, width: 60, height: 60)
        newsButton.setImage(newsImage, for: .normal)
        newsButton.addTarget(self, action: #selector(newsButtonClicked), for: .touchUpInside)
        addSubview(newsButton)
        
        let reserveImage = UIImage(named: "reserveButton") as UIImage?
        reserveButton = UIButton(type: UIButtonType.custom) as UIButton
        reserveButton.frame = CGRect(x: 158, y: 580, width: 60, height: 60)
        reserveButton.setImage(reserveImage, for: .normal)
        reserveButton.addTarget(self, action: #selector(reserveButtonClicked), for: .touchUpInside)
        addSubview(reserveButton)
        
        let infoImage = UIImage(named: "infoButton") as UIImage?
        infoButton = UIButton(type: UIButtonType.custom) as UIButton
        infoButton.frame = CGRect(x: 275, y: 580, width: 60, height: 60)
        infoButton.setImage(infoImage, for: .normal)
        infoButton.addTarget(self, action: #selector(infoButtonClicked), for: .touchUpInside)
        addSubview(infoButton)
        
    }
}

extension CustomDetailWindow
{
    @objc func newsButtonClicked(sender: UIButton!)
    {
        let url = URL(string: "http://www.library.ucla.edu/news-events")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @objc func reserveButtonClicked(sender: UIButton!)
    {
        let url = URL(string: "http://www.library.ucla.edu/clicc/study-rooms")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @objc func infoButtonClicked(sender:UIButton!)
    {
        let url = URL(string: "http://www.library.ucla.edu")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
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
