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
    
    func clearChannels() {
        channels.removeAll()
    }
}
