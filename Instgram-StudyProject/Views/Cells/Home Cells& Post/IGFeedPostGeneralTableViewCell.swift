//
//  IGFeedPostGeneralTableViewCell.swift
//  Instgram-StudyProject
//
//  Created by Mina Hany on 24/02/2022.
//

import UIKit

class IGFeedPostGeneralTableViewCell: UITableViewCell {
    
    
    static let identifier = "IGFeedPostGeneralTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}
