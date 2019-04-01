//
//  URLFactory.swift
//  McCOLLINSMedia
//
//  Created by Lokesh Yadav on 28/12/18.
//  Copyright © 2018 Lokesh Yadav. All rights reserved.
//

import Foundation
class URLFactory: NSObject {
    
    func webServiceCall(methodName method:String, with parameter:Dictionary<String, String>, completion: @escaping (_ stringURL: Data, _ response: URLResponse, _ error: Error?) -> Void) {
        var urlString = baseAPIUrl
        urlString.append(method)
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: requestForCommon(url: url!, parameter: parameter)) { (data, response, error) in
            
            if let error = error {
                let code = (error as NSError).code
                print("Error:\(code) : \(error.localizedDescription)")
                //completion(code)
                return
            }
            guard let response = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            DispatchQueue.main.async(execute: {
                completion(data!, response, error)
            })
            }.resume()
        
        
    }
    
    func webServicRaiseRequest(methodName method:String, with parameter:Dictionary<String, Any>, completion: @escaping (_ stringURL: Data, _ response: URLResponse, _ error: Error?) -> Void) {
        var urlString = baseAPIUrl
        urlString.append(method)
        //  print(parameter)
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: requestForRaiseRequest(url: url!, parameter: parameter)) { (data, response, error) in
            
            if let error = error {
                let code = (error as NSError).code
                print("Error:\(code) : \(error.localizedDescription)")
                //completion(code)
                return
            }
            guard let response = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            DispatchQueue.main.async(execute: {
                completion(data!, response, error)
            })
            }.resume()
        
        
    }
    
    
    func requestForRaiseRequest(url:URL,parameter:Dictionary<String, Any>) -> URLRequest {
        var request = URLRequest(url: url)
        let jsonDat = try? JSONSerialization.data(withJSONObject: parameter, options: [])
        //let jsonString = String(data: jsonDat!, encoding: .utf8)
        // print(jsonString!)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonDat
        return request
        
    }
    
    func requestForCommon(url:URL,parameter:Dictionary<String, String>) -> URLRequest {
        var request = URLRequest(url: url)
        let jsonDat = try? JSONSerialization.data(withJSONObject: parameter, options: [])
        request.httpMethod = "POST"
        let jsonString = String(data: jsonDat!, encoding: .utf8)
        print(jsonString!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonDat
        return request
        
    }
    
    
}

