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
    var isFollow: FollowState
}
public enum FollowState{
    case following
    case notFollowing
}
protocol UserFollowTableViewCellDelegate : AnyObject{
    func didTapFollowUnFollowButton(model:UserFollow)
}
class UserFollowTableViewCell: UITableViewCell {
    private var model: UserFollow?
    weak var delegate : UserFollowTableViewCellDelegate?
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
        button.backgroundColor = .systemBlue
        button.tintColor = .secondaryLabel
        
        button.layer.masksToBounds = true
        button.setTitle("Follow", for: .normal)
        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(userImageView)
        addSubview(userTitleLabel)
        addSubview(followButton)
        addSubview(userNameLabel)
        selectionStyle = .none
        followButton.addTarget(self, action: #selector(didTapFollowUnFollow), for: .touchUpInside)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = height/2
        let imageSize = contentView.height-4
        let heightLabel = (contentView.height/2)-4
        let buttonWidth =  contentView.width > 500 ? 220.0 : contentView.width/4
        userImageView.frame = CGRect(x: 4, y: 4, width: imageSize, height: imageSize)
        followButton.frame = CGRect(x: contentView.width-4-buttonWidth, y: (contentView.height-40)/2, width: buttonWidth, height: 40)
        userTitleLabel.frame = CGRect(x: userImageView.right + 4, y: 2, width: contentView.width-(userImageView.width+4)-buttonWidth, height: heightLabel)
        userNameLabel.frame = CGRect(x: userImageView.right + 4, y: userTitleLabel.bottom+4, width: width-(userImageView.width+4)-buttonWidth, height: heightLabel-2)
        userImageView.layer.cornerRadius = (height-4)/2
        followButton.layer.cornerRadius = 12
        
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
        self.model = user
        userTitleLabel.text = user.title
        userImageView.image = UIImage(named: user.image)
        userNameLabel.text = user.username
        switch user.isFollow {
        case .following :
            followButton.setTitle("UnFollow", for: .normal)
            followButton.setTitleColor(.label, for: .normal)
            followButton.backgroundColor = .systemBackground
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.label.cgColor
        case .notFollowing:
            followButton.setTitle("Follow", for: .normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.backgroundColor = .link
            followButton.layer.borderWidth = 0
        }
        
    }
    @objc private func didTapFollowUnFollow(){
        guard let model = model else {
            return
        }
        delegate?.didTapFollowUnFollowButton(model: model)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
