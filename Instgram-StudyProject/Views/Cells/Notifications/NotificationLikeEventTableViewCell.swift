//
//  NotificationLikeEventTableViewCell.swift
//  Instgram-StudyProject
//
//  Created by Mina Hany on 07/03/2022.
//

import UIKit


protocol NotificationLikeEventTableViewCellDelegate: AnyObject{
    func didTapPostButton(model: UserNotification)
}
class NotificationLikeEventTableViewCell: UITableViewCell {
    static let identifier = "NotificationLikeEventTableViewCell"
    public weak var delegate :NotificationLikeEventTableViewCellDelegate?
    private var model: UserNotification?
    private let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "test5")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .tertiarySystemBackground
        return imageView
    }()
    private let label : UILabel = {
        let label = UILabel()
        label.tintColor = .label
        label.font = .systemFont(ofSize: 17)
        label.text = "@MinaZakaria liked your post."
        label.numberOfLines = 0
        return label
    }()
    private lazy var postButton : UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
//        button.addTarget(self, action: #selector(didTapPost), for: .touchUpInside)
//        button.setImage(UIImage(named: "test"), for: .normal)
        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        postButton.addTarget(self, action: #selector(didTapPost), for: .touchUpInside)
        clipsToBounds = true
        selectionStyle = .none
        addSubview(label)
        addSubview(profileImageView)
        addSubview(postButton)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        profileImageView.image = nil
        postButton.setTitle(nil, for: .normal)
        postButton.backgroundColor = nil
        postButton.layer.borderWidth = 0
    }
    
   
    override func layoutSubviews(){
        super.layoutSubviews()
        //profileImage, label, button
        profileImageView.frame = CGRect(x: 4, y: 4, width: contentView.height-4 , height: contentView.height-4)
        profileImageView.layer.cornerRadius = (contentView.height-4)/2
        let buttonWidth = contentView.width > 500 ? 220 : contentView.width/4
        postButton.frame = CGRect(x: contentView.width-(contentView.height-4),
                                  y: 4,
                                  width: contentView.height-4,
                                  height: contentView.height-4)
        label.frame = CGRect(x: profileImageView.right+6, y: 4, width: contentView.width-buttonWidth-profileImageView.width, height: contentView.height-4)
//        postButton.layer.cornerRadius = 12
        
    }
    
    
    public func config(with model:UserNotification){
        self.model = model
        
        switch model.type {
        case .follow(_):
            break
        case .like(let post):
            let thumbnail = post.thumbnailImage
            guard !thumbnail.absoluteString.contains("googl.com") else{
                return
            }
//            postButton.sd_setImage(with: thumbnail, for: .normal, completed: nil)
            postButton.setImage(UIImage(named: "test6"), for: .normal)
            break
        }
        label.text = model.text 
//        profileImageView.sd_setImage(with: model.user.profilePic, completed: nil)
        profileImageView.image = UIImage(named: "test4")
        print("Our model: ",self.model )
    }
    
    @objc private func didTapPost(){
        print("Our model: ",self.model )
        print("Our model2: ",model )
        guard let model = self.model else {
            return
        }

        delegate?.didTapPostButton(model: model)
    }
}
