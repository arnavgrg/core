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
import Motion

class SignInViewController: UIViewController, GIDSignInUIDelegate
{
    var signInButton: UIButton!
    var signOutButton: UIButton!
    var backgroundImage: UIImageView!
    
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
        GIDSignIn.sharedInstance().delegate = self
        
        GIDSignIn.sharedInstance().signInSilently()
        
        sleep(3) //TODO: Find another way to prevent the signin buttons from popping up if the user is already logged in
        
        if (GIDSignIn.sharedInstance().currentUser != nil)
        {
            goToMap()
        }
        else
        {
            setupBackground()
            setupSignOutButton()
            setupSignInButton()
            
            signInButton.animate(.delay(0.5), .fade(1.00), .translate(y: -50))
            signOutButton.animate(.delay(1), .fade(1.00), .translate(y: -50))
        }
    }
    
    func receiveResponse(user: GIDGoogleUser)
    {
        print("Receive response called")
        
        goToMap()
        
        print("GIDSignIn User was nil")
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SignInViewController: GIDSignInDelegate
{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!)
    {
        if (error == nil)
        {
            if (user.hostedDomain != nil && (user.hostedDomain! == "g.ucla.edu" || user.hostedDomain! == "ucla.edu")) //domain check
            {
                // Perform any operations on signed in user here.
                
                let userId = user.userID
                let fullName = user.profile.name
                // ...
                print(userId ?? "nil")
                print(fullName ?? "nil")
                goToMap()
            }
            else
            {
                print("Domain is not ucla affiliated, it is \(user.hostedDomain)")
                GIDSignIn.sharedInstance().signOut()
            }
        }
        else
        {
            print("\(error.localizedDescription)")
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!)
    {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
}

extension SignInViewController
{
    func setupBackground()
    {
        backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.image = UIImage(named: "iphone6_launch")
        backgroundImage.contentMode = .scaleToFill
        view.addSubview(backgroundImage)
        
        NSLayoutConstraint(item: backgroundImage, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: backgroundImage, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: backgroundImage, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: backgroundImage, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        
        backgroundImage.layoutIfNeeded()
    }
    
    func setupSignInButton() //TODO: Sign in button is a different size and design than everything else
    {
        signInButton = FlatButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        signInButton.addTarget(self, action:#selector(signIn), for: .touchUpInside)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 18)
        signInButton.backgroundColor = UIColor(rgb: 0xF49B78)
        signInButton.alpha = 0.00
        signInButton.cornerRadiusPreset = .cornerRadius8
        view.addSubview(signInButton)
        
        NSLayoutConstraint(item: signInButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60).isActive = true
        NSLayoutConstraint(item: signInButton, attribute: .bottom, relatedBy: .equal, toItem: signOutButton, attribute: .top, multiplier: 1.0, constant: -15).isActive = true
        NSLayoutConstraint(item: signInButton, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 30).isActive = true
        NSLayoutConstraint(item: signInButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: -30).isActive = true
        
        signInButton.layoutIfNeeded()
    }
    
    func setupSignOutButton()
    {
        signOutButton = FlatButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        signOutButton.addTarget(self, action:#selector(signOut), for: .touchUpInside)
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 18)
        signOutButton.backgroundColor = UIColor(rgb: 0x64B0CC)
        signOutButton.alpha = 0.00
        signOutButton.cornerRadiusPreset = .cornerRadius8
        view.addSubview(signOutButton)
        
        NSLayoutConstraint(item: signOutButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60).isActive = true
        NSLayoutConstraint(item: signOutButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -30).isActive = true
        NSLayoutConstraint(item: signOutButton, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 30).isActive = true
        NSLayoutConstraint(item: signOutButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: -30).isActive = true
        
        
        signOutButton.layoutIfNeeded()
    }
}

@objc
extension SignInViewController
{
    func signIn()
    {
        GIDSignIn.sharedInstance().signIn()
    }
    
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
}


