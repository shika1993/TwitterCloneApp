//
//  ViewController.swift
//  TwitterCloneApp
//
//  Created by 鹿内翔平 on 2020/12/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tweetTimeLineTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTimeLineTableView.dataSource = self
        tweetTimeLineTableView.estimatedRowHeight = 600
        tweetTimeLineTableView.rowHeight = UITableView.automaticDimension
        tweetTimeLineTableView.register(UINib(nibName: "TweetCellTableViewCell", bundle: nil), forCellReuseIdentifier: "customTweetCell")
    }
    
}

//MARK:- TableViewdelegate & TableviewDatasource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tweetCell = tweetTimeLineTableView.dequeueReusableCell(withIdentifier: "customTweetCell") as! TweetCellTableViewCell
        if indexPath.row == 2 {
            tweetCell.messageLabel.text = "１４０文字に満たない写真付き"
        }else if indexPath.row == 3{
            tweetCell.messageLabel.text = "１４０文字に満たない写真なし"
            tweetCell.tweetImageView.isHidden = true
        }else if indexPath.row == 4{
            tweetCell.tweetImageView.isHidden = true
        }
        
        return tweetCell
    }
    
    
}
