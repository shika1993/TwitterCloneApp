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
    func finishGetTweetInfo(tweets:[Tweet], Ids:[Int])
}

protocol finishGetMoreTweetInfoDelegate{
    func finishGetMoreTweetInfo(tweets:[Tweet], Ids:[Int])
}

protocol cannotGetTweetFromApiDelegate {
    func cannotGetTweetFromApi()
}

class GetTweetsFromApi {
    
    let bearerToken = K.baereKey
    var finishGetTweetInfodelegate: finishGetTweetInfoDelegate?
    var cannotGetTweetFromApiDelegate: cannotGetTweetFromApiDelegate?
    var finishGetMoreTweetInfoDelegate: finishGetMoreTweetInfoDelegate?
    var tweets:[Tweet] = []
    var Ids:[Int] = []
    
    func makeRequest(keyWord:String) {
        let url = K.serchUrl + keyWord
        let encoderUrlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let encodedUrl = URL(string: encoderUrlString!)
        let headers: HTTPHeaders = [
            "Authorization":bearerToken,
        ]
        tweets.removeAll()
        AF.request(encodedUrl!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers, interceptor: .none).responseJSON { (response) in
            if let value = response.value{
                let json = JSON(value)
                for tweetInfo in json["statuses"].arrayValue {
                    let tweet = Tweet(
                        Id: tweetInfo["id"].int ?? 0,
                        profileImageUrlString: tweetInfo["user"]["profile_image_url"].string ?? "",
                        name: tweetInfo["user"]["name"].string ?? "",
                        userID: tweetInfo["user"]["screen_name"].string ?? "",
                        createdAt: tweetInfo["created_at"].string ?? "",
                        text: tweetInfo["text"].string ?? "",
                        mediaUrlString: tweetInfo["extended_entities"]["media"][0]["media_url"].string ?? "",
                        favoriteCount: tweetInfo["favorite_count"].int ?? 0,
                        retweetCount: tweetInfo["retweet_count"].int ?? 0
                    )
                    self.tweets.append(tweet)
                    self.Ids.append(tweetInfo["id"].int ?? 0)
                }
                self.finishGetTweetInfodelegate?.finishGetTweetInfo(tweets: self.tweets, Ids: self.Ids)
                self.tweets.removeAll()
            }else{
                self.cannotGetTweetFromApiDelegate?.cannotGetTweetFromApi()
            }
        }
    }
    
    func makeMoreRequest(keyWord:String, Id:Int){
        let url = K.serchUrl + keyWord + K.maxIdString + String(Id)
        let encoderUrlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let encodedUrl = URL(string: encoderUrlString!)
        let headers: HTTPHeaders = [
            "Authorization":bearerToken,
        ]
        tweets.removeAll()
        AF.request(encodedUrl!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers, interceptor: .none).responseJSON { (response) in
            if let value = response.value{
                let json = JSON(value)
                for tweetInfo in json["statuses"].arrayValue {
                    let tweet = Tweet(
                        Id: tweetInfo["id"].int ?? 0,
                        profileImageUrlString: tweetInfo["user"]["profile_image_url"].string ?? "",
                        name: tweetInfo["user"]["name"].string ?? "",
                        userID: tweetInfo["user"]["screen_name"].string ?? "",
                        createdAt: tweetInfo["created_at"].string ?? "",
                        text: tweetInfo["text"].string ?? "",
                        mediaUrlString: tweetInfo["extended_entities"]["media"][0]["media_url"].string ?? "",
                        favoriteCount: tweetInfo["favorite_count"].int ?? 0,
                        retweetCount: tweetInfo["retweet_count"].int ?? 0
                    )
                    
                    self.tweets.append(tweet)
                    self.Ids.append(tweetInfo["id"].int ?? 0)
                }
                self.finishGetMoreTweetInfoDelegate?.finishGetMoreTweetInfo(tweets: self.tweets, Ids: self.Ids)
                self.tweets.removeAll()
            }else{
                self.cannotGetTweetFromApiDelegate?.cannotGetTweetFromApi()
            }
        }
    }
    
}
