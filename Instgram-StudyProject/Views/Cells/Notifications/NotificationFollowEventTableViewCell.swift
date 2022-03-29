//
//  NotificationFollowEventTableViewCell.swift
//  Instgram-StudyProject
//
//  Created by Mina Hany on 07/03/2022.
//

import UIKit

protocol NotificationFollowEventTableViewCellDelegate: AnyObject{
    func didTapFollowUnFollowButton(model: UserNotification)
}
class NotificationFollowEventTableViewCell: UITableViewCell {
    private var model : UserNotification?
    static let identifier = "NotificationFollowEventTableViewCell"
    public weak var delegate :NotificationFollowEventTableViewCellDelegate?
    private let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .tertiarySystemBackground
        imageView.image = UIImage(named: "text1")
        return imageView
    }()
    private let label : UILabel = {
        let label = UILabel()
        label.tintColor = .label
        label.font = .systemFont(ofSize: 17)
        label.text = "@RamyMicheal has follow you."
        label.numberOfLines = 1
        return label
    }()
    private lazy var followButton : UIButton = {
        let button = UIButton()
//        button.setTitle("Follow Back", for: .normal)
//        button.titleEdgeInsets = UIEdgeInsets(top: 4 , left: 4, bottom: 4, right: 4)
//        button.tintColor = .white
//        button.backgroundColor = .link
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
      
        contentView.addSubview(label)
        contentView.addSubview(profileImageView)
        contentView.addSubview(followButton)
        followButton.addTarget(self, action: #selector(didTapFollowUnFollow), for: .touchUpInside)
        clipsToBounds = true
        selectionStyle = .none

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        profileImageView.image = nil
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
    }
    
    
    override func layoutSubviews(){
        super.layoutSubviews()
        
        profileImageView.frame = CGRect(x: 4, y: 4, width: contentView.height-4 , height: contentView.height-4)
        profileImageView.layer.cornerRadius = (contentView.height-4)/2
        let buttonWidth: CGFloat = 108
        let buttonHeight: CGFloat = 32
        followButton.frame = CGRect(x: contentView.width-(buttonWidth-4),
                                    y: (contentView.height-buttonHeight)/2,
                                    width: buttonWidth,
                                    height: buttonHeight)
        
        label.frame = CGRect(x: profileImageView.right+6, y: 4, width: contentView.width-buttonWidth-8-profileImageView.width, height: contentView.height-4)
        followButton.layer.cornerRadius = 12
        
        
        /**
         
         let buttonWidth = contentView.width > 500 ? 220 : contentView.width/4
         postButton.frame = CGRect(x: contentView.width-(contentView.height-4), y: 4, width: contentView.height-4, height: contentView.height-4)
         label.frame = CGRect(x: profileImageView.right+6, y: 4, width: contentView.width-buttonWidth-profileImageView.width, height: contentView.height-4)
         */
    }
    
    public func config(with model:UserNotification){
        self.model = model
      
        switch model.type {
        case .follow(let state):
            switch state {
            case .following:
                configForFollow()
            case .notFollowing:
                configForUnFollow()
            }
            break
        case .like(_):
            break
        }
        label.text =  model.text
        profileImageView.image = UIImage(named: "test3")
        //profileImageView.sd_setImage(with: model.user.profilePic, completed: nil)
        
        
    }
    
    
    @objc private func didTapFollowUnFollow(){
        print("Our model: ",self.model )
        print("Our model2: ",model )
        guard let model = model else {
            return
        }
        delegate?.didTapFollowUnFollowButton(model: model)
    }
    private func configForFollow(){
        followButton.setTitle("UnFollow", for: .normal)
        followButton.backgroundColor = .tertiarySystemBackground
        followButton.tintColor = .label
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    private func configForUnFollow(){
        followButton.setTitle("Follow Back", for: .normal)
        followButton.backgroundColor = .link
        followButton.tintColor = .white
        followButton.layer.borderWidth = 0
    }
}
