//
//  AppDelegate.swift
//  Chatterbox
//
//  Created by Madhusudhan B.R on 4/3/17.
//  Copyright © 2017 Madhusudhan B.R. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import CoreLocation
//import FBSDKCoreKit
//import FBSDKLoginKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var locationManager: CLLocationManager?
    var coordinate: CLLocationCoordinate2D?
    
   let APP_ID = "D9F96673-96C1-E628-FF28-90F9B1B07400"
    let SECRET_KEY = "77F98C94-8A92-9A76-FFDB-A4FF21D55000"
    let VERSION_NUM = "v1"
    
    let backendless = Backendless.sharedInstance()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        FIRApp.configure()
        backendless.initApp(APP_ID, secret: SECRET_KEY, version: VERSION_NUM)
    
        FIRDatabase.database().persistenceEnabled = true
        
        
        //facebook
       // FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
        
        
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        locationManagerStart()
        
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        locationManagerStop()
    }

    //MARK:  LocationManger fuctions
    
    func locationManagerStart() {
        
        if locationManager == nil {
            print("init locationManager")
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            locationManager!.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.requestWhenInUseAuthorization()
            locationManager!.requestAlwaysAuthorization()
            
        }
        
        print("have location manager")
        locationManager!.startUpdatingLocation()
    }
    
    func locationManagerStop() {
        locationManager!.stopUpdatingLocation()
    }
    
    //MARK: CLLocationManager Delegate
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        
        coordinate = newLocation.coordinate
    }
    
    
//    //MARK: FacebookLogin
//    
//    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
//        
//        let result = FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
//        
//        if result {
//            
//            let token = FBSDKAccessToken.currentAccessToken()
//            
//            let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email"], tokenString: token.tokenString, version: nil, HTTPMethod: "GET")
//            
//            request.startWithCompletionHandler({ (connection, result, error : NSError!) -> Void in
//                
//                if error == nil {
//                    let facebookId = result["id"]! as! String
//                    
//                    let avatarUrl = "https://graph.facebook.com/\(facebookId)/picture?type=normal"
//                    
//                    //update backendless user with avatar link
//                    updateBackendlessUser(facebookId, avatarUrl: avatarUrl)
//                    
//                } else {
//                    print("Facebook request error \(error)")
//                }
//            })
//            
//            let fieldsMapping = ["id" : "facebookId", "name" : "name", "email" : "email"]
//            
//            backendless.userService.loginWithFacebookSDK(token, fieldsMapping: fieldsMapping)
//        }
//        
//        return result
//    }
    
   

    
}

