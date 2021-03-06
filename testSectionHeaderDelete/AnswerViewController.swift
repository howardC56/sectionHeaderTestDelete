//
//  ViewController.swift
//  testSectionHeaderDelete
//
//  Created by Howard Chang on 10/1/20.
//

import UIKit

class AnswerViewController: UIViewController {
    
    var sections = [Section]()
//    {
//        didSet {
//            DispatchQueue.main.async {
//                self.mainView.collectionView.reloadData()
//            }
//            self.mainView.collectionView.collectionViewLayout = self.createCompositionalLayout(sections: self.sections)
//        }
//    }
    
    private let mainView = MainView()
    
    override func loadView() {
        view = mainView
    }
    
    lazy private var deleteButton: UIBarButtonItem = {
        [unowned self] in
        let barButton = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteSection(_:)))
        barButton.tintColor = .label
        return barButton
    }()
    
    lazy private var addButton: UIBarButtonItem = {
        [unowned self] in
        let barButton = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addSection(_:)))
        barButton.tintColor = .label
        return barButton
    }()
    
    @objc func addSection(_ sender: UIBarButtonItem) {
        let section = Section(id: UUID().uuidString, type: .mediumCell, title: "Hi", items: [Item(id: UUID().uuidString, name: "test")])
        sections.append(section)
        
        let sectionLastIndex = sections.count - 1
        
        // Add section in collection view
        let indexSet = IndexSet(integer: sectionLastIndex)
        mainView.collectionView.insertSections(indexSet)
    }
    
    @objc func deleteSection(_ sender: UIBarButtonItem) {
        
        if !sections.isEmpty {
            
            let sectionLastIndex = sections.count - 1
            
            sections.removeLast()
            
            // Remove section in collection view
            let indexSet = IndexSet(integer: sectionLastIndex)
            mainView.collectionView.deleteSections(indexSet)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItems = [addButton, deleteButton]
        
        loadData()
        
        mainView.collectionView.dataSource = self
        
        // Setup collection view layout
        mainView.collectionView.collectionViewLayout = self.createCompositionalLayout()
        
        // Show data on collection view
        mainView.collectionView.reloadData()
    }
    
    private func loadData() {
        let data = [
            Section(id: UUID().uuidString, type: .mediumCell, title: "Hi", items: [Item(id: UUID().uuidString, name: "test")]),
            Section(id: UUID().uuidString, type: .mediumCell, title: "test", items: [Item(id: UUID().uuidString, name: "test"),Item(id: UUID().uuidString, name: "test")])]
        
        sections = data
    }
    
}

extension AnswerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediumCell.reuseIdentifier, for: indexPath) as? MediumCell else { fatalError("unable to dequeue MediumCell") }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainSectionHeader.reuseIdentifier, for: indexPath) as? MainSectionHeader else { fatalError("Section Header failed to load") }
        sectionHeader.title.text = sections[indexPath.section].title.capitalized
        return sectionHeader
    }
    
}

extension AnswerViewController {
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        
        guard !sections.isEmpty else { return UICollectionViewLayout() }
        
        let layout = UICollectionViewCompositionalLayout { [unowned self]
            sectionIndex, layoutEnvironment in
            
            let section = self.sections[sectionIndex]
            
            return self.createMediumTableSection(using: section)
        }
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 15
        layout.configuration = configuration
        return layout
    }
    
//    func createCompositionalLayout(sections: [Section]) -> UICollectionViewLayout {
//        guard !sections.isEmpty else { return UICollectionViewLayout() }
//        let layout = UICollectionViewCompositionalLayout { [weak self]
//            sectionIndex, layoutEnvironment in
//            let section = sections[sectionIndex]
//
//            return self?.createMediumTableSection(using: section)
//        }
//
//        let configuration = UICollectionViewCompositionalLayoutConfiguration()
//        configuration.interSectionSpacing = 15
//        layout.configuration = configuration
//        return layout
//    }
    
    func createMediumTableSection(using section: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.33))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .fractionalWidth(0.55))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        layoutSection.interGroupSpacing = 20
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        return layoutSection
    }
    
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(80))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return layoutSectionHeader
    }
    
}

