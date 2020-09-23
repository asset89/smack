//
//  MessageServices.swift
//  Smack
//
//  Created by Asset Ryskul on 9/18/20.
//  Copyright © 2020 Asset Ryskul. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    static let instance = MessageService()
    
    var channels = [Channel]()
    var messages = [Message]()
    var selectedChannel: Channel?
    
    func findAllChannels(completion: @escaping CompletionHandler) {
        AF.request(GET_CHANNEL_URL, method: .get, headers: BEARER_HEADER).responseJSON { (responce) in
            if responce.error == nil {
                guard let data = responce.data else {return}
                do {
                    if let json = try JSON(data: data).array {
                        for item in json {
                            let name = item["name"].stringValue
                            let channelDescription = item["description"].stringValue
                            let id = item["_id"].stringValue
                            let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                            self.channels.append(channel)
                        }
                    }
                } catch {
                    debugPrint(responce.error?.errorDescription as Any)
                }
                NotificationCenter.default.post(name: NOTIF_CHANNEL_LOADED, object: nil)
                completion(true)
            } else {
                completion(false)
                debugPrint(responce.error as Any)
            }
        }
    }
    
    func findAllMessagesforChannel(channelId: String, completion: @escaping CompletionHandler) {
        AF.request("\(GET_CHANNEL_MESSAGES)\(channelId)", method: .get, headers: BEARER_HEADER).responseJSON { (responce) in
            if responce.error == nil {
                self.clearMessages()
                guard let data = responce.data else {return}
                do {
                    if let json = try JSON(data: data).array {
                        for item in json {
                            let messageBody = item["messageBody"].stringValue
                            let channelId = item["channelId"].stringValue
                            let id = item["_id"].stringValue
                            let userName = item["userName"].stringValue
                            let userAvatar = item["userAvatar"].stringValue
                            let userAvatarColor = item["userAvatarColor"].stringValue
                            let timestamp = item["timeStamp"].stringValue
                            let message = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timestamp: timestamp)
                            self.messages.append(message)
                        }
                    }
                } catch {
                    debugPrint(responce.error?.errorDescription as Any)
                }
                //NotificationCenter.default.post(name: NOTIF_CHANNEL_LOADED, object: nil)
                completion(true)
            } else {
                completion(false)
                debugPrint(responce.error as Any)
            }
        }
    }
    
    func clearChannels() {
        channels.removeAll()
    }
    
    func clearMessages() {
        messages.removeAll()
    }
}
