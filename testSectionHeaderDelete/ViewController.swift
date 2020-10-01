//
//  ViewController.swift
//  testSectionHeaderDelete
//
//  Created by Howard Chang on 10/1/20.
//

import UIKit

class ViewController: UIViewController {
    
    var sections = [Section]() {
        didSet {
            DispatchQueue.main.async {
            
                self.mainView.collectionView.reloadData()
            }
            self.mainView.collectionView.collectionViewLayout = self.createCompositionalLayout(sections: self.sections)
        }
    }
    
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
    
    @objc func deleteSection(_ sender: UIBarButtonItem) {
        if !sections.isEmpty {
        sections.removeLast()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = deleteButton
        mainView.collectionView.dataSource = self
        loadData()
    }

    
    private func loadData() {
        let data = [Section(id: UUID().uuidString, type: .mediumCell, title: "Hi", items: [Item(id: UUID().uuidString, name: "test")]), Section(id: UUID().uuidString, type: .mediumCell, title: "test", items: [Item(id: UUID().uuidString, name: "test"),Item(id: UUID().uuidString, name: "test")])]
        sections = data
    }

}

extension ViewController: UICollectionViewDataSource {
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


extension ViewController {
    
    func createCompositionalLayout(sections: [Section]) -> UICollectionViewLayout {
    guard !sections.isEmpty else { return UICollectionViewLayout() }
           let layout = UICollectionViewCompositionalLayout { [weak self]
               sectionIndex, layoutEnvironment in
               let section = sections[sectionIndex]

                return self?.createMediumTableSection(using: section)
               }
           
           let configuration = UICollectionViewCompositionalLayoutConfiguration()
           configuration.interSectionSpacing = 15
           layout.configuration = configuration
           return layout
    }
    
    func makeEmptyBackgroundDecoration() -> NSCollectionLayoutDecorationItem {
        let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
        backgroundItem.contentInsets = NSDirectionalEdgeInsets(top: 50, leading: 0, bottom: 20, trailing: 0)
        return backgroundItem
    }
    
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

