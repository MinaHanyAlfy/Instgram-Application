//
//  ProfileTabsCollectionReusableView.swift
//  Instgram-StudyProject
//
//  Created by Mina Hany on 27/02/2022.
//

import UIKit
protocol ProfileTapsCollectionReusableViewDelegate : AnyObject{
    func didTapGridButton()
    func didTapTagButton()
}

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileTabsCollectionReusableView"
    struct Constans{
        static let padding : CGFloat = 10
            
    }
    public weak var delegate : ProfileTapsCollectionReusableViewDelegate?
    private let gridButton : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        button.tintColor = .systemBlue
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    private let taggedButton : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        button.tintColor = .lightGray
        
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(gridButton)
        addSubview(taggedButton)
        gridButton.addTarget(self, action: #selector(didGridButtonTapped), for: .touchUpInside)
        taggedButton.addTarget(self, action: #selector(didTagButtonTapped), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
            
        let size = height - (Constans.padding*2)
        let gridButtonX = ((width/2)-size)/2
        gridButton.frame = CGRect(x: gridButtonX, y: Constans.padding, width: size, height: size)
        taggedButton.frame = CGRect(x: gridButtonX+(width/2), y: Constans.padding, width: size, height: size)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didGridButtonTapped(){
        gridButton.tintColor = .systemBlue
        taggedButton.tintColor = .lightGray
        delegate?.didTapGridButton()
    }
    @objc private func didTagButtonTapped(){
        gridButton.tintColor = .lightGray
        taggedButton.tintColor = .systemBlue
        delegate?.didTapGridButton()
    }
}
