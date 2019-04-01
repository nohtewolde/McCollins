//
//  Update.swift
//  McCollins
//
//  Created by Noh Tewolde on 3/31/19.
//  Copyright © 2019 Noh Tewolde. All rights reserved.
//

import UIKit

class Update: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var txtID: UITextField!
    @IBOutlet weak var txtFirstname: UITextField!
    @IBOutlet weak var txtLastname: UITextField!
    @IBOutlet weak var txtDob: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMoblile: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    
    var userEmail : String?
    var userID : User = User()
    var updateStatus : String?
    var errorMessage : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "blueBackground")!)
    }
    
    @IBAction func btnChoosePhoto(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose Source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imgUser.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        if changes() {
            APIHandler.sharedInstance.updateUser(user: userID) { (updateStatus, errorMessage) in
                if errorMessage == nil{
                    self.lblMessage.text = "Successful update of user data."
                } else {
                    self.lblMessage.text = "Failure to update user data."
                }
            }
        }
        
    }
    
    func changes() -> Bool{
        
        if (userID.dob != txtDob.text || userID.emailId != txtEmail.text || userID.fName != txtFirstname.text ||
            userID.lName != txtLastname.text || userID.gender != txtGender.text || userID.mobile != txtMoblile.text){
            return true
        }
        return false
    }
    
    func setUser() -> User{
        let usrObj : User?
        usrObj = userID
        usrObj?.fName = txtFirstname.text
        usrObj?.lName = txtLastname.text
        usrObj?.emailId = txtEmail.text
        usrObj?.gender = txtGender.text
        usrObj?.dob = txtDob.text
        usrObj?.mobile = txtMoblile.text
        return usrObj!
    }
    
}
