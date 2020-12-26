//
//  ViewController.swift
//  TwitterCloneApp
//
//  Created by 鹿内翔平 on 2020/12/20.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tweetTimeLineTableView: UITableView!
    let getTweet = GetTweetsFromApi()
    
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
            getTweet.makeRequest(keyWord: searchTextField.text!)
            searchTextField.text = ""
            searchTextField.resignFirstResponder()
        }
        
    }
    
}

//MARK:- TableViewdelegate & TableviewDatasource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tweetCell = tweetTimeLineTableView.dequeueReusableCell(withIdentifier: "customTweetCell") as! TweetCellTableViewCell
        return tweetCell
    }
    
    
}

//MARK:- UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if searchTextField.text! == ""{
           return true
        }else{
            getTweet.makeRequest(keyWord: searchTextField.text!)
            searchTextField.text = ""
            searchTextField.resignFirstResponder()
        }
        
        return true
    }
    
}

//MARK:- finishGetTweetInfoDelegate{
extension ViewController: finishGetTweetInfoDelegate{
    
    func finishGetTweetInfo(tweets: [Tweet]) {
        print(tweets)
    }
}
