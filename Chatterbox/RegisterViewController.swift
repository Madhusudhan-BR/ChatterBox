//
//  RegisterViewController.swift
//  Chatterbox
//
//  Created by Madhusudhan B.R on 4/3/17.
//  Copyright © 2017 Madhusudhan B.R. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var backendless = Backendless.sharedInstance()
    var email : String?
    var username : String?
    var password :String?
    var avatarImage :UIImage?
    var newUser : BackendlessUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newUser = BackendlessUser()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   //MARK: IBctions 
    
    @IBAction func registerButtonPressed(sender: AnyObject) {
        if emailTextField.text != "" && usernameTextField.text != "" && passwordTextField.text != "" {
            
            ProgressHUD.show("Registering...")
            
            email = emailTextField.text
            username = usernameTextField.text
            password = passwordTextField.text
            
            register(self.email!, username: self.username!, password: self.password!, avatarImage: self.avatarImage)
        } else {
            //worning to user
            ProgressHUD.showError("All fields are required")
        }
    
    }
    
    @IBAction func uploadPhotoButtonPressed(sender: AnyObject) {
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        let camera = Camera(delegate_: self)
        
        
        let takePhoto = UIAlertAction(title: "Take Photo", style: .Default) { (alert: UIAlertAction!) -> Void in
            camera.PresentPhotoCamera(self, canEdit: true)
        }
        
        let sharePhoto = UIAlertAction(title: "Photo Library", style: .Default) { (alert : UIAlertAction!) -> Void in
            camera.PresentPhotoLibrary(self, canEdit: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (aler : UIAlertAction!) -> Void in
            print("Cancelled")
        }
        
        
        optionMenu.addAction(takePhoto)
        optionMenu.addAction(sharePhoto)
        optionMenu.addAction(cancelAction)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
        
        
        
        
        
    }
    
    //MARK: UIImagepickercontroller delegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        self.avatarImage = (info[UIImagePickerControllerEditedImage] as! UIImage)
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    
 //MARK : Backendless user registration
    
    
    func register(email: String, username: String, password: String, avatarImage: UIImage?) {
        
        //UIApplication.sharedApplication().registerForRemoteNotifications()
        
        if avatarImage == nil {
            newUser!.setProperty("Avatar", object: "")
        } else {
            
            uploadAvatar(avatarImage!, result: { (imageLink) -> Void in
                
                let properties = ["Avatar" : imageLink!]
                
                self.backendless.userService.currentUser!.updateProperties(properties)
                
                self.backendless.userService.update(self.backendless.userService.currentUser, response: { (updatedUser: BackendlessUser!) -> Void in
                    print("Updated current user avatar")
                    }, error: { (fault : Fault!) -> Void in
                        print("Error couldnt set avatar image \(fault)")
                })
            })
        }
        
        newUser!.email = email
        newUser!.name = username
        newUser!.password = password
        
        backendless.userService.registering(newUser, response: { (registeredUser : BackendlessUser!) -> Void in
            
            ProgressHUD.dismiss()
            
            //login new user
            self.loginUser(email, username: username, password: password)
            
            self.usernameTextField.text = ""
            self.passwordTextField.text = ""
            self.emailTextField.text = ""
            
        }) { (fault : Fault!) -> Void in
            print("Server reported an error, couldnt register new user: \(fault)")
        }
        
    }
    
    func loginUser(email:String,username:String,password:String){

        backendless.userService.login(email, password: password , response: { (user : BackendlessUser!) in
            // segue to recents view controller 
            
            let vc = UIStoryboard(name:"Main",bundle: nil).instantiateViewControllerWithIdentifier("chatVC") as! UITabBarController
            self.presentViewController(vc, animated: true, completion: nil)
            vc.selectedIndex=0
            
            
        }) { (fault : Fault!) in
        
            print("Server error! \(fault)")
            
        }
        
    }

}
