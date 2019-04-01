//
//  User.swift
//  McCollins
//
//  Created by Noh Tewolde on 3/31/19.
//  Copyright © 2019 Noh Tewolde. All rights reserved.
//

import UIKit

class User: NSObject {
    var id      : String?
    var fName   : String?
    var lName   : String?
    var emailId : String?
    var mobile  : String?
    var paswd   : String?
    var dob     : String?
    var gender  : String?
    
    override init(){
        id = ""
        fName = ""
        lName = ""
        emailId = ""
        mobile = ""
        paswd   = ""
        dob = ""
        gender = ""
    }
    
    init(newElement: [String:Any]){
        fName = newElement["fname"] as? String
        lName = newElement["lname"] as? String
        emailId = newElement["email"] as? String
        mobile = newElement["mobile"] as? String
        paswd = newElement["password"] as? String
        dob = newElement["dob"] as? String
        gender = newElement["gender"] as? String
    }
}
