//
//  WelcomeViewController.swift
//  Chatterbox
//
//  Created by Madhusudhan B.R on 4/3/17.
//  Copyright © 2017 Madhusudhan B.R. All rights reserved.
//

import UIKit
//import FBSDKCoreKit
//import FBSDKLoginKit



class WelcomeViewController: UIViewController {
    
    let backendless = Backendless.sharedInstance()
    var currentUser:BackendlessUser?
    
    @IBOutlet weak var registerButton: UIButton!
    //@IBOutlet weak var fbLoginButton: FBSDKLoginButton!
    
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidAppear(animated: Bool) {
        backendless.userService.setStayLoggedIn(true)
        currentUser = backendless.userService.currentUser
        
        if currentUser != nil {
            
            dispatch_async(dispatch_get_main_queue()){
            
            let vc = UIStoryboard(name:"Main",bundle: nil).instantiateViewControllerWithIdentifier("chatVC") as! UITabBarController
            self.presentViewController(vc, animated: true, completion: nil)
            vc.selectedIndex=0
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //registerButton.layer.borderWidth = 1
        registerButton.layer.cornerRadius = 20
        
        loginButton.layer.borderColor = UIColor.blueColor().CGColor
        //loginButton.layer.borderWidth = 1
        loginButton.layer.cornerRadius = 20
        
        registerButton.layer.borderColor = UIColor.blueColor().CGColor
        
        // Do any additional setup after loading the view.
        
        //fbLoginButton.readPermissions = ["public_profile","email"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
