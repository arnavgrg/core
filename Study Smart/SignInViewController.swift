//
//  ViewController.swift
//  Study Smart
//
//  Created by Parth Pendurkar on 10/21/17.
//  Copyright © 2017 UCLA DevX. All rights reserved.
//

import UIKit
import GoogleSignIn
import GoogleMaps
import Material

class SignInViewController: UIViewController, GIDSignInUIDelegate
{
    var signInButton: GIDSignInButton!
    var signOutButton: UIButton!
    
    //Debug buttons
    var mapScreenButton: UIButton = UIButton()
    var updateInfoButton: UIButton = UIButton()
    //
    
    var user: User?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        //Debug buttons
        //TODO: Clean up and remove
        updateInfoButton.frame = CGRect(x: 250, y: 300, width: 40, height: 40)
        mapScreenButton.frame = CGRect(x: 150, y: 400, width: 40, height: 40)
        updateInfoButton.backgroundColor = UIColor.black
        updateInfoButton.addTarget(self, action:#selector(updateInfo), for: .touchUpInside)
        mapScreenButton.backgroundColor = UIColor.green
        mapScreenButton.addTarget(self, action:#selector(goToMap), for: .touchUpInside)
        view.addSubview(updateInfoButton)
        view.addSubview(mapScreenButton)
        //
        
        setupSignOutButton()
        setupSignInButton()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SignInViewController
{
    func setupSignInButton() //TODO: Sign in button is a different size and design than everything else
    {
        signInButton = GIDSignInButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.colorScheme = GIDSignInButtonColorScheme.light
        signInButton.style = .wide
        view.addSubview(signInButton)
        
        NSLayoutConstraint(item: signInButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30).isActive = true
        NSLayoutConstraint(item: signInButton, attribute: .bottom, relatedBy: .equal, toItem: signOutButton, attribute: .topMargin, multiplier: 1.0, constant: -20).isActive = true
        NSLayoutConstraint(item: signInButton, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leadingMargin, multiplier: 1.0, constant: 20).isActive = true
        NSLayoutConstraint(item: signInButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailingMargin, multiplier: 1.0, constant: -20).isActive = true
        
        signInButton.layoutIfNeeded()
    }
    
    func setupSignOutButton()
    {
        signOutButton = FlatButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        signOutButton.addTarget(self, action:#selector(signOut), for: .touchUpInside)
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.backgroundColor = Color.lightBlue.base
        view.addSubview(signOutButton)
        
        NSLayoutConstraint(item: signOutButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30).isActive = true
        NSLayoutConstraint(item: signOutButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1.0, constant: -20).isActive = true
        NSLayoutConstraint(item: signOutButton, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leadingMargin, multiplier: 1.0, constant: 20).isActive = true
        NSLayoutConstraint(item: signOutButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailingMargin, multiplier: 1.0, constant: -20).isActive = true
        
        
        signOutButton.layoutIfNeeded()
    }
}

@objc
extension SignInViewController
{
    func signOut()
    {
        // print("logged out of:" + (GIDSignIn.sharedInstance().currentUser?.profile.name)!)
        print("signOut() called")
        GIDSignIn.sharedInstance().signOut()
    }
    
    func goToMap()
    {
        print("goToMap() called")
        
        let mapViewController = MapViewController()
        self.present(mapViewController, animated: true, completion: nil)
    }
    
    func updateInfo()
    {
        print("updateInfo() called")
        
        if(GIDSignIn.sharedInstance() != nil && user == nil){
            user = User(id: GIDSignIn.sharedInstance().currentUser.userID, name: GIDSignIn.sharedInstance().currentUser.profile.name, email: GIDSignIn.sharedInstance().currentUser.profile.email)
        }
    }
}

