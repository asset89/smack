//
//  AuthServices.swift
//  Smack
//
//  Created by Asset Ryskul on 9/8/20.
//  Copyright © 2020 Asset Ryskul. All rights reserved.
//

import Foundation
import Alamofire

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
        let header: HTTPHeaders = [
            "Content-Type" : "application/json; charset=utf-8"
        ]
        let body : [String : String] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        AF.request(REGISTER_URL, method: .post, parameters: body, encoder: JSONEncoding.default as! ParameterEncoder, headers: header).responseString { (responce) in
            if responce.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(responce.error as Any)
            }
        }
    }
    
}
