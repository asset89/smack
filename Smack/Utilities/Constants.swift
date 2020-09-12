//
//  Constants.swift
//  Smack
//
//  Created by Asset Ryskul on 9/3/20.
//  Copyright © 2020 Asset Ryskul. All rights reserved.
//

import Foundation
import Alamofire

typealias CompletionHandler = (_ Success: Bool) -> ()

//segues
let TO_LOGIN = "toLogin"
let SW_REAR = "sw_rear"
let SW_FRONT = "sw_front"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND_TO_CHANNEL = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

//user defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//URL Constants
let BASE_URL = "https://smackschat.herokuapp.com/v1/"
let REGISTER_URL = "\(BASE_URL)account/register"
let LOGIN_URL = "\(BASE_URL)account/login"
let USER_ADD_URL = "\(BASE_URL)user/add"

//Headers
let HEADERS: HTTPHeaders = [
    "Content-Type" : "application/json; charset=utf-8"
]

