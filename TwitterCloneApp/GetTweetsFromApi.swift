//
//  GetTweetsFromApi.swift
//  TwitterCloneApp
//
//  Created by 鹿内翔平 on 2020/12/22.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol finishGetTweetInfoDelegate{
    func finishGetTweetInfo(tweets:[Tweet])
}

class GetTweetsFromApi {
    
    let bearerToken = K.baereKey
    var finishGetTweetInfodelegate: finishGetTweetInfoDelegate?
    var tweets:[Tweet] = []
    
    func makeRequest(keyWord:String) {
        let url = K.serchUrl + keyWord
        let encoderUrlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let encodedUrl = URL(string: encoderUrlString!)
        let headers: HTTPHeaders = [
            "Authorization":bearerToken,
        ]
        AF.request(encodedUrl!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers, interceptor: .none).responseJSON { (response) in
            if let value = response.value{
                let json = JSON(value)
                for tweetInfo in json["statuses"].arrayValue {
                    let tweet = Tweet(profileImageUrlString: tweetInfo["user"]["profile_image_url"].string ?? "",
                          name: tweetInfo["user"]["name"].string ?? "",
                          createdAt: tweetInfo["created_at"].string ?? "",
                          text: tweetInfo["text"].string ?? "",
                          mediaUrl: tweetInfo["extended_entities"]["media"][0]["media_url"].string ?? "",
                          favoriteCount: tweetInfo["favorite_count"].int ?? 0,
                          retweetCount: tweetInfo["retweet_count"].int ?? 0
                        )
                    self.tweets.append(tweet)
                }
                self.finishGetTweetInfodelegate?.finishGetTweetInfo(tweets: self.tweets)
                self.tweets.removeAll()
            }
        }
    }
    
    
    
}
