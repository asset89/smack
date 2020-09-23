//
//  AuthServices.swift
//  Smack
//
//  Created by Asset Ryskul on 9/8/20.
//  Copyright © 2020 Asset Ryskul. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SVProgressHUD

class AuthService{
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken : String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail : String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        
        let body : [String : String] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        AF.request(REGISTER_URL, method: .post, parameters: body, encoder: JSONParameterEncoder.default, headers: HEADERS).responseString { (responce) in
            
            if responce.error == nil {
                completion(true)
                
            } else {
                completion(false)
                debugPrint(responce.error as Any)
                
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()

        let parameters : [String : String] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        AF.request(LOGIN_URL, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: HEADERS).responseString { (responce) in
            if responce.error == nil {
//                if let json = responce.value as? Dictionary<String, Any> {
//                    if let email = json["user"] as? String {
//                        self.userEmail = email
//                    }
//                    if let token = json["token"] as? String {
//                        self.authToken = token
//                    }
//                }
                
                guard let data = responce.data else {return}
                do {
                    let json = try JSON(data: data)
                    self.userEmail = json["username"].stringValue
                    self.authToken = json["hash"].stringValue
                    
                } catch {
                    debugPrint(responce.error?.errorDescription as Any)
                }
                
                self.isLoggedIn = true
                completion(true)
            } else {
                
                completion(false)
                debugPrint(responce.error as Any)
            }
        }
    }
    
    func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        
        let parameters : [String : String] = [
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        ]
        
        AF.request(USER_ADD_URL, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: BEARER_HEADER).responseString { (responce) in
            if responce.error == nil {
                guard let data = responce.data else {return}
                self.setupUser(data: data)
                completion(true)
            } else {
                completion(false)
                debugPrint(responce.error as Any)
            }
        }
    }
    
    func findUserByEmail(completion: @escaping CompletionHandler) {
        
        AF.request("\(USER_BY_EMAIL_URL)\(userEmail)", method: .get, headers: BEARER_HEADER).responseString { (responce) in
            if responce.error == nil {
                guard let data = responce.data else {return}
                self.setupUser(data: data)
                completion(true)
            } else {
                completion(false)
                debugPrint(responce.error as Any)
            }
        }
    }
    
    func setupUser(data: Data) {
        do {
            let json = try JSON(data: data)
            let id = json["_id"].stringValue
            let name = json["name"].stringValue
            let email = json["email"].stringValue
            let avatarName = json["avatarName"].stringValue
            let avatarColor = json["avatarColor"].stringValue
            UserDataService.instance.setUserData(id: id, avatarColor: avatarColor, avatarName: avatarName, email: email, name: name)
        } catch {
            print("error in JSON parsing")
        }
    }
    
}
