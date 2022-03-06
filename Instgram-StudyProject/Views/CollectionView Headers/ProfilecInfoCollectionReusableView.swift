//
//  ProfilecInfoCollectionReusableView.swift
//  Instgram-StudyProject
//
//  Created by Mina Hany on 27/02/2022.
//

import UIKit
protocol ProfileInforCollectionReusableViewDelegate: AnyObject{
    func profileHeaderDidTapPostsButton(_ header: ProfilecInfoCollectionReusableView)
    func profileHeaderDidTapFollowingButton(_ header: ProfilecInfoCollectionReusableView)
    func profileHeaderDidTapFollowersButton(_ header: ProfilecInfoCollectionReusableView)
    func profileHeaderDidTapEditProfileButton(_ header: ProfilecInfoCollectionReusableView)
}

class ProfilecInfoCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfilecInfoCollectionReusableView"
  
    public weak var delegate : ProfileInforCollectionReusableViewDelegate?
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "test7")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private let followingButton: UIButton = {
        let button = UIButton()
//        button.tintColor = .secondaryLabel
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.setTitle("1000   Following", for: .normal)
        button.titleLabel?.textAlignment  = .center
        button.titleLabel?.numberOfLines = 2
        return button
    }()
    private let followersButton: UIButton = {
        let button = UIButton()
//        button.tintColor = .secondaryLabel
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.setTitle("1000   Followers", for: .normal)
        button.titleLabel?.textAlignment  = .center
        button.titleLabel?.numberOfLines = 2
        return button
    }()
    private let editProfileButton: UIButton = {
        let button = UIButton()
//        button.tintColor = .secondaryLabel
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.clipsToBounds = true
        button.setTitle("Edit Your Profile", for: .normal)
//        button.backgroundColor = .label
        return button
    }()
    private let postsButton: UIButton = {
        let button = UIButton()
//        button.tintColor = .secondaryLabel
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.setTitle("13        Posts", for: .normal)
        button.titleLabel?.textAlignment  = .center
        button.titleLabel?.numberOfLines = 2
        return button
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.tintColor = .secondaryLabel
        
        label.text = "Mina Hany"
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.tintColor = .secondaryLabel
        label.text = "Hello From Other Side"
        return label
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        addButtonActions()
        backgroundColor = .systemBackground
    }
    private func addSubViews(){
        addSubview(profileImageView)
        addSubview(editProfileButton)
        addSubview(nameLabel)
        addSubview(bioLabel)
        addSubview(followersButton)
        addSubview(followingButton)
        addSubview(postsButton)
    }
    private func addButtonActions(){
        
        postsButton.addTarget(self, action: #selector(didTapPostsButton), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
        followersButton.addTarget(self, action: #selector(didTapFollowersButton), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
       
        let profilePhotoSize = width/4
        profileImageView.layer.cornerRadius = profilePhotoSize/2
        let buttonHeight = profilePhotoSize/2
        let countButtonWidth = (width-10-profilePhotoSize)/3
        editProfileButton.layer.cornerRadius = 12
        profileImageView.frame = CGRect(x: 6,
                                        y: 6,
                                        width: profilePhotoSize,
                                        height: profilePhotoSize).integral
        
        postsButton.frame = CGRect(x: profileImageView.right,
                                        y: 6,
                                        width: countButtonWidth ,
                                        height: buttonHeight).integral
        
        followersButton.frame = CGRect(x: postsButton.right,
                                        y: 6,
                                        width: countButtonWidth,
                                        height: buttonHeight).integral
        followingButton.frame = CGRect(x: followersButton.right,
                                        y: 6,
                                        width: countButtonWidth,
                                        height: buttonHeight).integral
        nameLabel.frame = CGRect(x: 6,
                                        y: profileImageView.bottom,
                                        width: countButtonWidth,
                                        height: 52).integral
        let bioLabelSize = bioLabel.sizeThatFits(frame.size)
        bioLabel.frame = CGRect(x: 6,
                                               y: nameLabel.bottom,
                                               width: width-12,
                                height: bioLabelSize.height).integral
        editProfileButton.frame = CGRect(x: 6,
                                        y: bioLabel.bottom+16,
                                        width: width-12,
                                        height: buttonHeight-12).integral
    }
    
    
    
    //MARK: - Actions
    @objc private func didTapPostsButton(){
        delegate?.profileHeaderDidTapPostsButton(self)
    }
    @objc private func didTapFollowingButton(){
        delegate?.profileHeaderDidTapFollowingButton(self)
    }
    @objc private func didTapFollowersButton(){
        delegate?.profileHeaderDidTapFollowersButton(self)
    }
    @objc private func didTapEditProfileButton(){
        delegate?.profileHeaderDidTapEditProfileButton(self)
    }
}
