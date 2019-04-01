//
//  APIHandler.swift
//  McCOLLINSMedia
//
//  Created by Lokesh Yadav on 28/12/18.
//  Copyright © 2018 Lokesh Yadav. All rights reserved.
//

import UIKit

let baseAPIUrl                  =  "http://mccollinsmedia.com/myproject/service/"
let RegistrationApi             =  "registerUser"
let LoginApi                    =  "checklogin"
let ListAttractionsApi          =  "listAttractions"
let UpdateUserApi               =  "updateUser"


enum PossibleErrors : Error {
    
    case errorInResponse
    case emptyFile
    
}
class APIHandler: NSObject {
    
    
    let urlFactory = URLFactory()
    static var sharedInstance = APIHandler()
    private override init() {}
    var user  =  User()
    
    
    func registration(user:User, completion: @escaping (_ registerInfo: String?, _ error: String?) -> Void) {
        let dic = ["fname"      :user.fName,
                   "lname"      :user.lName,
                   "email"      :user.emailId,
                   "mobile"     :user.mobile,
                   "password"   :user.paswd,
                   "cpassword"  :user.paswd,
                   "dob"        :user.dob,
                   "gender"     :user.gender
        ]
        
        urlFactory.webServiceCall(methodName: RegistrationApi, with: dic as! Dictionary<String, String>) { (data, response, error) in
            do{
                if let jsonResult =  try JSONSerialization.jsonObject(with: data, options:[]) as? Dictionary<String, Any>{
                     //print(jsonResult)
                    if let iserror = jsonResult["iserror"] as? String{
                        if iserror == "Yes" {
                            let info = jsonResult["data"] as! String
                            completion(nil , info)
                        }else{
                            let info = jsonResult["message"] as! String
                            completion(info , nil)

                        }
                    }
                }else{
                    completion(nil , "Unknown error")
                }
            }catch{
                print("Failure to Serialize Json")
                print(error)
                
            }
            
        }
    }
    
    func updateUser(user:User, completion: @escaping (_ registerInfo: String?, _ error: String?) -> Void) {
        let dic = ["id"         :user.id,
                   "fname"      :user.fName,
                   "lname"      :user.lName,
                   "email"      :user.emailId,
                   "mobile"     :user.mobile,
                   "dob"        :user.dob,
                   "gender"     :user.gender]
        
        urlFactory.webServiceCall(methodName: UpdateUserApi, with: dic as! Dictionary<String, String>) { (data, response, error) in
            do{
                if let jsonResult =  try JSONSerialization.jsonObject(with: data, options:[]) as? Dictionary<String, Any>{
                   // print(jsonResult)
                    if let iserror = jsonResult["iserror"] as? String{
                        if iserror == "Yes" {
                            let info = jsonResult["data"] as! String
                            completion(nil , info)
                        }else{
                            let info = jsonResult["message"] as! String
                            completion(info , nil)
                            
                        }
                    }
                }
            }catch{
                print(error)
                
            }
            
        }
    }
    
    
    
   
    func login(userName email:String, withPassword pwd:String, completion: @escaping (_ user: User?, _ error: String?) -> Void) {
        let dic = ["email":email,
                   "password":pwd]
        
        urlFactory.webServiceCall(methodName: LoginApi, with: dic) { (data, response, jsonError) in
            do{
                if let jsonResult =  try JSONSerialization.jsonObject(with: data, options:[]) as? Dictionary<String, Any>{
                    //print(jsonResult)
                    if let iserror = jsonResult["iserror"] as? String{
                        if iserror == "Yes" {
                            let info = jsonResult["message"] as! String
                            completion(nil , info)
                        }else{
                            if  let datajson = jsonResult["data"] as? [[String:Any]]{
                                let user = self.setupCustomer(jsonResult: datajson[0])
                                 completion(user , nil)
                            }
                            
                        }
                    }
                }else{
                    completion(nil , "Unknown error")
                }
            }catch{
                print(error)
            }
        }
    }
    
    

    func getAttractions(email:String, completion: @escaping (_ orderArray: [Attraction]?, _ error: String?) -> Void) {
        let dict = ["email":email]
        urlFactory.webServiceCall(methodName: ListAttractionsApi , with: dict) { (data, response, error) in
            do{
                if let jsonResult =  try JSONSerialization.jsonObject(with: data, options:[]) as? Dictionary<String, Any>{
                    if let iserror = jsonResult["iserror"] as? String{
                        if iserror == "Yes" {
                            let info = jsonResult["message"] as! String
                            completion(nil , info)
                        }else{
                            if  let datajson = jsonResult["data"] as? [[String:Any]]{
                                let attractions = self.setupAttractions(dataJson: datajson)
//                                print(jsonResult)
                                completion(attractions , nil)
                            }

                        }
                    }
                }else{
                    completion(nil , "Unknown error")
                }
            }catch{
                print(error)
                completion([] , error.localizedDescription)
            }
        }
    }


    func setupCustomer(jsonResult: [String:Any]) -> User{
        let usrObj : User = User(newElement: jsonResult)
//        usrObj.fName = jsonResult["fname"] as? String
//        usrObj.lName = jsonResult["lname"] as? String
//        usrObj.emailId = jsonResult["email"] as? String
//        usrObj.mobile = jsonResult["mobile"] as? String
//        usrObj.paswd = jsonResult["password"] as? String
//        usrObj.dob = jsonResult["dob"] as? String
//        usrObj.gender = jsonResult["gender"] as? String
        return usrObj
    }
    
    func setupAttractions(dataJson: [[String:Any]]) -> [Attraction]{
        var attObj : [Attraction] = []
        for i in dataJson{
            attObj.append(Attraction(newElement: i))
        }
        return attObj
    }
    
}


