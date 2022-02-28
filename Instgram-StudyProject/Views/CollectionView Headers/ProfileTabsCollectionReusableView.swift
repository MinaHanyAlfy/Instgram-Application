//
//  ProfileTabsCollectionReusableView.swift
//  Instgram-StudyProject
//
//  Created by Mina Hany on 27/02/2022.
//

import UIKit

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileTabsCollectionReusableView"
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
