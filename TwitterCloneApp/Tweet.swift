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
    let createdAt:String
    let text:String
    let mediaUrl:String
    let favoriteCount:Int
    let retweetCount:Int
    
    init(profileImageUrlString:String, name:String, createdAt:String, text:String, mediaUrl:String, favoriteCount:Int, retweetCount:Int){
        
        self.profileImageUrlString = profileImageUrlString
        self.name = name
        self.createdAt = createdAt
        self.text = text
        self.mediaUrl = mediaUrl
        self.favoriteCount = favoriteCount
        self.retweetCount = retweetCount
    }
    
}
