//
//  MainHeader.swift
//  testSectionHeaderDelete
//
//  Created by Howard Chang on 10/1/20.
//

import UIKit

class MainSectionHeader: UICollectionReusableView {
        static let reuseIdentifier = "MainSectionHeader"
        
        public lazy var title: UILabel = {
            let label = UILabel()
            label.textColor = .label
            return label
        }()
        
        public lazy var subtitle: UILabel = {
            let label = UILabel()
            label.textColor = .secondaryLabel
            label.font = UIFont.preferredFont(forTextStyle: .subheadline)
            return label
        }()
        
        private lazy var separatorView: UIView = {
               let separator = UIView(frame: .zero)
               separator.translatesAutoresizingMaskIntoConstraints = false
               separator.backgroundColor = .quaternaryLabel
               return separator
           }()
        
        private lazy var stackView: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [separatorView, title, subtitle])
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            stack.setCustomSpacing(10, after: separatorView)
            return stack
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            commonSetup()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func commonSetup() {
            setupHeader()
        }
        
        private func setupHeader() {
            addSubview(stackView)
            NSLayoutConstraint.activate([separatorView.heightAnchor.constraint(equalToConstant: 1), stackView.leadingAnchor.constraint(equalTo: leadingAnchor), stackView.trailingAnchor.constraint(equalTo: trailingAnchor), stackView.topAnchor.constraint(equalTo: topAnchor), stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)])
        }
}
