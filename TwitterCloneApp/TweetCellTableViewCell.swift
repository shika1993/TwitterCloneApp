//
//  TweetCellTableViewCell.swift
//  TwitterCloneApp
//
//  Created by 鹿内翔平 on 2020/12/20.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var favLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tweetImageView.layer.masksToBounds = false
        tweetImageView.layer.cornerRadius = 25
        tweetImageView.clipsToBounds = true
        userProfileImageView.layer.masksToBounds = false
        userProfileImageView.layer.cornerRadius = 25
        userProfileImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
