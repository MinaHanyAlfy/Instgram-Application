//
//  NotificationFollowEventTableViewCell.swift
//  Instgram-StudyProject
//
//  Created by Mina Hany on 07/03/2022.
//

import UIKit

protocol NotificationFollowEventTableViewCellDelegate: AnyObject{
    func didTapFollowUnFollowButton()
}
class NotificationFollowEventTableViewCell: UITableViewCell {
    static let identifier = "NotificationFollowEventTableViewCell"
    weak var delegate :NotificationFollowEventTableViewCellDelegate?
    private let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let label : UILabel = {
        let label = UILabel()
        label.tintColor = .label
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 1
        return label
    }()
    private let followButton : UIButton = {
        let button = UIButton()
        
        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        selectionStyle = .none
        addSubview(label)
        addSubview(profileImageView)
        addSubview(followButton)
        followButton.addTarget(self, action: #selector(didTapFollowUnFollow), for: .touchUpInside)
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
    }
    
    public func config(with model:String){
        
    }
    
    
    @objc private func didTapFollowUnFollow(){
        delegate?.didTapFollowUnFollowButton()
    }
}
