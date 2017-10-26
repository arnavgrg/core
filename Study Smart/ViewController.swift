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

class ViewController: UIViewController, GIDSignInUIDelegate
{
    
    var usernameLabel: UILabel = UILabel()
    var passwordLabel: UILabel = UILabel()
    var signInButton: GIDSignInButton = GIDSignInButton()
    var signOutButton: UIButton = UIButton()
    var mapScreenButton: UIButton = UIButton()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        usernameLabel.frame = CGRect(x: 50, y: 50, width: 100, height: 20)
        passwordLabel.frame = CGRect(x: 50, y: 100, width: 100, height: 20)
        usernameLabel.text = "Username"
        passwordLabel.text = "Password"
        
        signInButton.frame = CGRect(x: 50, y: 300, width: 40, height: 40)
        signOutButton.frame = CGRect(x: 50, y: 400, width: 40, height: 40)
        mapScreenButton.frame = CGRect(x: 150, y: 400, width: 40, height: 40)
        signOutButton.backgroundColor = UIColor.blue
        signOutButton.addTarget(self, action:#selector(didTapSignOut), for: .touchUpInside)
        mapScreenButton.backgroundColor = UIColor.green
        mapScreenButton.addTarget(self, action:#selector(goToMap), for: .touchUpInside)
        
        view.addSubview(usernameLabel)
        view.addSubview(passwordLabel)
        view.addSubview(signInButton)
        view.addSubview(signOutButton)
        view.addSubview(mapScreenButton)
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func didTapSignOut()
    {
        print("sign out button pressed")
        GIDSignIn.sharedInstance().signOut()
    }
    
    @objc func goToMap()
    {
        let mapViewController = MapViewController()
        self.present(mapViewController, animated: true, completion: nil)
    }

}

