//
//  LoginViewController.swift
//  Chatterbox
//
//  Created by Madhusudhan B.R on 4/3/17.
//  Copyright © 2017 Madhusudhan B.R. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let backendless = Backendless.sharedInstance()
    
    var email : String?
    var password : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: IBActions

    @IBAction func loginBarButtonItem(sender: AnyObject) {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            self.email = emailTextField.text
            self.password = passwordTextField.text
            
            //login the user 
            ProgressHUD.show("Logging in")
            loginUser(email!, password:password!)
        }
        else {
            ProgressHUD.showError("All fields are required!")
        }
    }
    
    func loginUser(email:String, password:String){
        
        
        // code for wrong password
        
        
        
        backendless.userService.login(email, password: password, response: { (user : BackendlessUser!) in
            
            ProgressHUD.dismiss()
            self.emailTextField.text = ""
            self.passwordTextField.text=""
            
            // segue to recents view
            let vc = UIStoryboard(name:"Main",bundle: nil).instantiateViewControllerWithIdentifier("chatVC") as! UITabBarController
            self.presentViewController(vc, animated: true, completion: nil)
            vc.selectedIndex=0
        }) { (fault : Fault!) in
            ProgressHUD.dismiss()
            print("Couldn't login user \(fault)")
        }
        
    }
}
