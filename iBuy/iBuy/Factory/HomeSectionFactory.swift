//
//  HomeSectionFactory.swift
//  e-commerceApp
//
//  Created by Baran Baran on 21.08.2024.
//

import UIKit

// MARK: - HomeSectionFactory
/// Factory class for creating layout sections in the home view.
final class HomeSectionFactory {
    static func buildLayout(for sectionType: SectionType) -> NSCollectionLayoutSection {
        switch sectionType {
        case .featured:
            return createFeaturedSection()
        case .category:
            return createCategorySection()
        case .products:
            return createProductsSection()
        }
    }
    
    private init(){}
}

// MARK: - Layout Section Creation
private extension HomeSectionFactory {
    static func createFeaturedSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.9)))
        item.contentInsets = .init(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(.screenHeight * 0.4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }

    static func createCategorySection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .absolute(.screenHeight * 0.25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary

        let header = createHeader(size: 75)
        section.boundarySupplementaryItems = [header]
        return section
    }

    static func createProductsSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.9)))
        item.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)

        let header = createHeader(size: 45)
        section.boundarySupplementaryItems = [header]
        return section
    }
}

// MARK: - Header Creation
private extension HomeSectionFactory {
    static func createHeader(size: CGFloat) -> NSCollectionLayoutBoundarySupplementaryItem {
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(size)),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
    }
}
