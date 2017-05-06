//
//  RegisterUser.swift
//  Chatterbox
//
//  Created by Madhusudhan B.R on 4/21/17.
//  Copyright © 2017 Madhusudhan B.R. All rights reserved.
//

import Foundation



func updateBackendlessUser(facebookId: String, avatarUrl: String) {
    
    var properties: [String: String]!
    
    if backendless.messagingService.getRegistration().deviceId != nil {
        let deviceId = backendless.messagingService.getRegistration().deviceId
        
        properties = ["Avatar" : avatarUrl, "deviceId" : deviceId]
    } else {
        properties = ["Avatar" : avatarUrl]
    }
    
    
    backendless.userService.currentUser.updateProperties(properties)
    
    backendless.userService.update(backendless.userService.currentUser, response: { (updatedUser : BackendlessUser!) -> Void in
        
        print("updated user is : \(updatedUser)")
        
    }) { (fault : Fault!) -> Void in
        print("Error couldnt update the devices id: \(fault)")
    }
    
}