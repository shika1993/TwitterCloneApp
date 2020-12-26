//
//  ViewController.swift
//  TwitterCloneApp
//
//  Created by 鹿内翔平 on 2020/12/20.
//

import UIKit
import SDWebImage
import PKHUD

class ViewController: UIViewController{
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tweetTimeLineTableView: UITableView!
    let getTweet = GetTweetsFromApi()
    let profileImageSizeTransformer = SDImageResizingTransformer(size: CGSize(width: 50, height: 50),scaleMode: .aspectFit)
    let mediaImageSizeTransformer = SDImageResizingTransformer(size: CGSize(width: 200, height: 300),scaleMode: .aspectFit)
    var timeLineTweets:[Tweet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTweet.finishGetTweetInfodelegate = self
        tweetTimeLineTableView.dataSource = self
        searchTextField.delegate = self
        tweetTimeLineTableView.estimatedRowHeight = 600
        tweetTimeLineTableView.rowHeight = UITableView.automaticDimension
        tweetTimeLineTableView.register(UINib(nibName: "TweetCellTableViewCell", bundle: nil), forCellReuseIdentifier: "customTweetCell")
        
    }
    
    @IBAction func serchTweetWithKeyWord(_ sender: UIButton) {
        
        if searchTextField.text! == ""{
           return
        }else{
            HUD.show(.progress)
            timeLineTweets.removeAll()
            getTweet.makeRequest(keyWord: searchTextField.text!)
            searchTextField.text = ""
            searchTextField.resignFirstResponder()
        }
    }
    
}

//MARK:- TableViewdelegate & TableviewDatasource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeLineTweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tweetCell = tweetTimeLineTableView.dequeueReusableCell(withIdentifier: "customTweetCell") as! TweetCellTableViewCell
        
        if timeLineTweets.count != 0{
            
            tweetCell.userProfileImageView.sd_setImage(with: URL(string: timeLineTweets[indexPath.row].profileImageUrlString), completed: nil)
            
            if timeLineTweets[indexPath.row].mediaUrlString == ""{
                tweetCell.tweetImageView.isHidden = true
            }else{
                tweetCell.tweetImageView.isHidden = false
                print(indexPath.row)
                tweetCell.tweetImageView.sd_setImage(with: URL(string: timeLineTweets[indexPath.row].mediaUrlString), completed: nil)
            }
            
            tweetCell.userNameLabel.text = timeLineTweets[indexPath.row].name
            tweetCell.userIDLabel.text = timeLineTweets[indexPath.row].userID
            tweetCell.createdAtLabel.text = timeLineTweets[indexPath.row].createdAt
            tweetCell.messageLabel.text = timeLineTweets[indexPath.row].text
            tweetCell.favLabel.text = String(timeLineTweets[indexPath.row].favoriteCount)
            tweetCell.retweetLabel.text = String(timeLineTweets[indexPath.row].retweetCount)
        }

        return tweetCell
    }
    
    
}

//MARK:- UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if searchTextField.text! == ""{
           return true
        }else{
            HUD.show(.progress)
            timeLineTweets.removeAll()
            getTweet.makeRequest(keyWord: searchTextField.text!)
            searchTextField.text = ""
            searchTextField.resignFirstResponder()
        }
        
        return true
    }
    
}

//MARK:- finishGetTweetInfoDelegate
extension ViewController: finishGetTweetInfoDelegate{
    
    func finishGetTweetInfo(tweets: [Tweet]) {
        
        if tweets.count == 0{
            showAletr()
        }else{
            timeLineTweets.append(contentsOf: tweets)
            tweetTimeLineTableView.reloadData()
        }
        HUD.hide()
    }
}

//MARK:- alert
extension ViewController {
    
    func showAletr(){
        let alert = UIAlertController(title: "検索結果がありません", message: "キーワードを再入力してください", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
