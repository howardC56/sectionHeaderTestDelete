//
//  MediumCell.swift
//  testSectionHeaderDelete
//
//  Created by Howard Chang on 10/1/20.
//

import UIKit

class MediumCell: UICollectionViewCell {
    static var reuseIdentifier: String = "EmptyCell"
    
    public lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 15
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "photo")
        return iv
    }()
    
    public lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.text = "Hello World"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupImageView()
        setupTitleLabel()
    }
    
      private func setupImageView() {
        addSubview(imageView)
        imageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 5, paddingRight: 5, height: 150)
    }
    
    private func setupTitleLabel() {
        addSubview(title)
        title.anchor(top: imageView.bottomAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 10, paddingRight: 0)
    }
}
