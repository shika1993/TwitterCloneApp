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
        
        tweetTimeLineTableView.delegate = self
        tweetTimeLineTableView.dataSource = self
        tweetTimeLineTableView.register(UINib(nibName: "TweetCellTableViewCell", bundle: nil), forCellReuseIdentifier: "customTweetCell")
    }
    
}

//MARK:- TableViewdelegate & TableviewDatasource
extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tweetCell = tweetTimeLineTableView.dequeueReusableCell(withIdentifier: "customTweetCell") as! TweetCellTableViewCell
        return tweetCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 400
    }
    
}
