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
    let dateformatter = DateFormatter()
    var timeLineTweets:[Tweet] = []
    var minId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getTweet.finishGetTweetInfodelegate = self
        getTweet.cannotGetTweetFromApiDelegate = self
        getTweet.finishGetMoreTweetInfoDelegate = self
        tweetTimeLineTableView.dataSource = self
        tweetTimeLineTableView.delegate = self
        searchTextField.delegate = self
        searchTextField.attributedPlaceholder = NSAttributedString(string: "キーワードを入力してください",attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        tweetTimeLineTableView.estimatedRowHeight = 600
        tweetTimeLineTableView.rowHeight = UITableView.automaticDimension
        tweetTimeLineTableView.register(UINib(nibName: "TweetCellTableViewCell", bundle: nil), forCellReuseIdentifier: "customTweetCell")
    }
    
    @IBAction func serchTweetWithKeyWord(_ sender: UIButton) {
        
        if searchTextField.text! == ""{
            searchTextField.resignFirstResponder()
           return
        }else{
            HUD.show(.progress)
            timeLineTweets.removeAll()
            getTweet.makeRequest(keyWord: searchTextField.text!)
            searchTextField.resignFirstResponder()
            
        }
    }
    
}

//MARK:- TableViewdelegate & TableviewDatasource
extension ViewController: UITableViewDataSource,UITableViewDelegate {
    
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
                tweetCell.tweetImageView.sd_setImage(with: URL(string: timeLineTweets[indexPath.row].mediaUrlString), completed: nil)
            }
            tweetCell.userNameLabel.text = timeLineTweets[indexPath.row].name
            tweetCell.userIDLabel.text = "@\(timeLineTweets[indexPath.row].userID)"
            tweetCell.createdAtLabel.text = String(timeLineTweets[indexPath.row].createdAt.prefix(10))
            tweetCell.messageLabel.text = timeLineTweets[indexPath.row].text
            tweetCell.favLabel.text = String(timeLineTweets[indexPath.row].favoriteCount)
            tweetCell.retweetLabel.text = String(timeLineTweets[indexPath.row].retweetCount)
        }
        
        return tweetCell
    }
    
    //オートページング
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if tweetTimeLineTableView.contentOffset.y + tweetTimeLineTableView.frame.size.height > tweetTimeLineTableView.contentSize.height {
            if timeLineTweets.count != 0{
                getTweet.makeMoreRequest(keyWord: searchTextField.text!, Id: minId)
                HUD.show(.progress)
            }
        }
    }

}

//MARK:- UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if searchTextField.text! == ""{
            searchTextField.resignFirstResponder()
            return true
        }else{
            HUD.show(.progress)
            timeLineTweets.removeAll()
            getTweet.makeRequest(keyWord: searchTextField.text!)
            searchTextField.resignFirstResponder()
            
        }
        
        return true
    }
    
}

//MARK:- finishGetTweetInfoDelegate
extension ViewController: finishGetTweetInfoDelegate,finishGetMoreTweetInfoDelegate,cannotGetTweetFromApiDelegate{
    
    func finishGetTweetInfo(tweets: [Tweet], Ids:[Int]) {
        
        if tweets.count == 0{
            showAlert(title: "検索結果がありません", message: "キーワードを再入力してください")
            searchTextField.text = ""
        }else{
            timeLineTweets.append(contentsOf: tweets)
            minId = Ids.min()! - 1
            tweetTimeLineTableView.reloadData()
            tweetTimeLineTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
        
        HUD.hide()
        
    }
    
    func finishGetMoreTweetInfo(tweets: [Tweet], Ids: [Int]) {
        if tweets.count == 0{
            showAlert(title: "検索結果がありません", message: "キーワードを再入力してください")
            searchTextField.text = ""
        }else{
            timeLineTweets.append(contentsOf: tweets)
            minId = Ids.min()! - 1
        }
        tweetTimeLineTableView.reloadData()
        HUD.hide()
    }
    
    func cannotGetTweetFromApi() {
        HUD.hide()
        showAlert(title: "通信エラー", message: "通信環境を確認し再検索してください。")
        searchTextField.text = ""
    }
}

//MARK:- alert
extension ViewController {
    
    func showAlert(title: String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
