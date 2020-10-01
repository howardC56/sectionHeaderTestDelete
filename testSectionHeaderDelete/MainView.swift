//
//  MainView.swift
//  testSectionHeaderDelete
//
//  Created by Howard Chang on 10/1/20.
//

import UIKit

class MainView: UIView {
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: self.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        cv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cv.backgroundColor = .white
        cv.register(MediumCell.self, forCellWithReuseIdentifier: MediumCell.reuseIdentifier)
        cv.register(MainSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainSectionHeader.reuseIdentifier)
        return cv
    }()
    
    override init(frame:CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        backgroundColor = .systemGray6
        addSubview(collectionView)
    }
    
}
