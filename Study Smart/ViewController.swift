//
//  ViewController.swift
//  Study Smart
//
//  Created by Parth Pendurkar on 10/21/17.
//  Copyright © 2017 UCLA DevX. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate
{
    
    var usernameLabel: UILabel = UILabel()
    var passwordLabel: UILabel = UILabel()
    var signInButton: GIDSignInButton = GIDSignInButton()

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
        
        view.addSubview(usernameLabel)
        view.addSubview(passwordLabel)
        view.addSubview(signInButton)
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

