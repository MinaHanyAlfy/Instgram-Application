//
//  NotificationLikeEventTableViewCell.swift
//  Instgram-StudyProject
//
//  Created by Mina Hany on 07/03/2022.
//

import UIKit


protocol NotificationLikeEventTableViewCellDelegate: AnyObject{
    func didTapPostButton()
}
class NotificationLikeEventTableViewCell: UITableViewCell {
    static let identifier = "NotificationLikeEventTableViewCell"
    weak var delegate :NotificationLikeEventTableViewCellDelegate?
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
    private let postButton : UIButton = {
        let button = UIButton()
        
        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        selectionStyle = .none
        addSubview(label)
        addSubview(profileImageView)
        addSubview(postButton)
        postButton.addTarget(self, action: #selector(didTapPost), for: .touchUpInside)
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
    }
    
    public func config(with model:String){
        
    }
    
    
    @objc private func didTapPost(){
        delegate?.didTapPostButton()
    }
}
