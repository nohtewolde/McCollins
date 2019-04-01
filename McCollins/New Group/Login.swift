//
//  Login.swift
//  McCollins
//
//  Created by Noh Tewolde on 3/30/19.
//  Copyright © 2019 Noh Tewolde. All rights reserved.
//

import UIKit

class Login: UIViewController {

    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var userObj : User?
    var errMsg : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "blueBackground")!)
        txtUsername.becomeFirstResponder()
    }

    override func viewDidAppear(_ animated: Bool) {
        if let userName = UserDefaults.standard.object(forKey: "username") as? String {
            txtUsername.text = userName
        }
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        lblMessage.text = ""
        //validating the username as proper email or not
        let response = Validation.shared.validate(values: (ValidationType.email, txtUsername.text!))
        switch response {
        case .success:
            let username = txtUsername.text
            let pwd = txtPassword.text
            APIHandler.sharedInstance.login(userName: username!, withPassword: pwd!) { (userObj, errMsg) in
                if errMsg == nil {
                    self.lblMessage.text = ""
                    UserDefaults.standard.set(self.txtUsername.text, forKey: "username")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "AttractionsTVC") as? AttractionsTVC
                    vc?.userID = username
                    self.navigationController?.pushViewController(vc!, animated: true)
                } else {
                    self.lblMessage.text = errMsg!
                }
            }
            break
        case .failure(_, let message):
            lblMessage.text = message.localized()
            print(message.localized())
        }
    }
    
    @IBAction func btnRegister(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Register")
        navigationController?.pushViewController(vc!, animated: true)
    }
    
}
