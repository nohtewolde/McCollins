//
//  Register.swift
//  McCollins
//
//  Created by Noh Tewolde on 3/30/19.
//  Copyright © 2019 Noh Tewolde. All rights reserved.
//

import UIKit

class Register: UIViewController {

    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var dateOfBirth: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    var userObj : User = User()
    var registerationStatus : String?
    var errorMessage : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "blueBackground")!)
        firstName.becomeFirstResponder()
    }

    @IBAction func register(_ sender: UIButton) {
        
        lblMessage.text = ""
        let response = validate()
        switch response {
        case .success:
            setUser(userObj: userObj)
            APIHandler.sharedInstance.registration(user: userObj) { (registerationStatus, errorMessage) in
                if errorMessage == nil {
                    self.lblMessage.text = registerationStatus!
                } else {
                    self.lblMessage.text = errorMessage!
                }
            }
            break
        case .failure(_, let message):
            lblMessage.text = lblMessage.text! + message.localized()
            print(message.localized())
        }
        
        
    }
    
    func setUser(userObj : User){
        userObj.fName = firstName.text
        userObj.lName = lastName.text
        userObj.emailId = email.text
        userObj.dob = dateOfBirth.text
        userObj.gender = gender.text
        userObj.mobile = mobileNumber.text
        userObj.id = email.text
        userObj.paswd = password.text
    }
    
    func validate() -> Valid{
                let response = Validation.shared.validate(values: (ValidationType.email, email.text!),
                                                          (ValidationType.password, password.text!),
                                                          (ValidationType.date, dateOfBirth.text!),
                                                          (ValidationType.phoneNo, mobileNumber.text!),
                                                          (ValidationType.stringWithFirstLetterCaps, lastName.text!),
                                                          (ValidationType.stringWithFirstLetterCaps, firstName.text!))
            return response
    }
    
    
    
    
}
