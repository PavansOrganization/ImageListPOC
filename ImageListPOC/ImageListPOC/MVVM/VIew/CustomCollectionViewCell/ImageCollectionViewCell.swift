//
//  ImageCollectionViewCell.swift
//  ImageListPOC
//
//  Created by test on 15/01/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import SnapKit
import SDWebImage

class ImageCollectionViewCell: UICollectionViewCell {
    
    static let ID = ImageCollectionViewCell.description()
    
    // MARK: UI Components
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
    
    // MARK: View Setup
    fileprivate func setupViews() {
        contentView.addSubview(imageView)
        imageView.snp.remakeConstraints { (make) in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalTo(contentView.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.left.equalTo(contentView.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(contentView.safeAreaLayoutGuide.snp.right)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalTo(titleLabel.snp.right)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
}

// MARK: Cell  Configuration method

extension ImageCollectionViewCell {
    func configureCell(viewModel: ImageDataViewModel) {
        self.imageView.image = AppConstants.placeholderImage
        self.titleLabel.text = viewModel.getImageTitle()
        self.descriptionLabel.text = viewModel.getImageDescription()
        guard let url = viewModel.getImageURL() else {
            return
        }
        self.imageView.sd_setImage(with: url, placeholderImage: AppConstants.placeholderImage)
    }
}
