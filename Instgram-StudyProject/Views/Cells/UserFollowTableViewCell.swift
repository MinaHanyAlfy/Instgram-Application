//
//  UserFollowTableViewCell.swift
//  Instgram-StudyProject
//
//  Created by Mina Hany on 06/03/2022.
//

import UIKit

struct UserFollow{
    var username: String
    var image:  String
    var title: String
    var isFollow:Bool
}
class UserFollowTableViewCell: UITableViewCell {
    static let identifier = "UserFollowTableViewCell"
    private let userImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private let userTitleLabel : UILabel = {
        let label =  UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.tintColor = .secondaryLabel
        return label
    }()
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 13)
        label.tintColor = .lightGray
        return label
    }()
    private let followButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(userImageView)
        addSubview(userTitleLabel)
        addSubview(followButton)
        addSubview(userNameLabel)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = height/2
        let heightLabel = (height/2)-4
        userImageView.frame = CGRect(x: 4, y: 4, width: height-4, height: height-4)
        userTitleLabel.frame = CGRect(x: userImageView.right + 4, y: 2, width: width-(userImageView.width+4), height: heightLabel)
        userNameLabel.frame = CGRect(x: userImageView.right + 4, y: userTitleLabel.bottom+4, width: width-(userImageView.width+4), height: height-heightLabel-2)
        userImageView.layer.cornerRadius = (height-4)/2
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userImageView.image =  nil
        userTitleLabel.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        userTitleLabel.text = nil
        
    }
    public func config(user: UserFollow){
        userTitleLabel.text = user.title
        userImageView.image = UIImage(named: user.image)
        userNameLabel.text = user.username
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
