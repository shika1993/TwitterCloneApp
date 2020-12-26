//
//  Tweet.swift
//  TwitterCloneApp
//
//  Created by 鹿内翔平 on 2020/12/22.
//

import Foundation

struct Tweet {
    
    let profileImageUrlString:String
    let name:String
    let userID:String
    let createdAt:String
    let text:String
    let mediaUrlString:String
    let favoriteCount:Int
    let retweetCount:Int
    
    init(profileImageUrlString:String, name:String, userID:String, createdAt:String, text:String, mediaUrlString:String, favoriteCount:Int, retweetCount:Int){
        
        self.profileImageUrlString = profileImageUrlString
        self.name = name
        self.userID = userID
        self.createdAt = createdAt
        self.text = text
        self.mediaUrlString = mediaUrlString
        self.favoriteCount = favoriteCount
        self.retweetCount = retweetCount
    }
    
}
