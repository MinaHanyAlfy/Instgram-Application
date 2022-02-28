//
//  PhotoCollectionViewCell.swift
//  Instgram-StudyProject
//
//  Created by Mina Hany on 27/02/2022.
//

import UIKit
import SDWebImage
class PhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "PhotoCollectionViewCell"
    private let photoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.frame = contentView.bounds
    }
    override func prepareForReuse(){
        super.prepareForReuse()
        photoImageView.image = nil
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(photoImageView)
        contentView.clipsToBounds = true
        accessibilityHint = "Double Tap To Open Post"
        accessibilityLabel = "User Post Image"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: UserPost){
        let thumbnailUrl = model.thumbnailImage
        photoImageView.sd_setImage(with: thumbnailUrl,completed: nil)
    }
    
    public func configure(debug image: String){
        photoImageView.image = UIImage(named: image)
        
    }
}
