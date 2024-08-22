//
//  HomeSectionFactory.swift
//  e-commerceApp
//
//  Created by Baran Baran on 21.08.2024.
//

import UIKit

/// Factory class for creating layout sections in the home view.
final class HomeSectionFactory {
    /// Creates a layout section based on the section type.
    /// - Parameter sectionType: The type of section to create.
    /// - Returns: An `NSCollectionLayoutSection` for the given section type.
    static func createLayout(for sectionType: SectionType) -> NSCollectionLayoutSection {
        switch sectionType {
        case .featured:
            return createFeaturedSection()
        case .category:
            return createCategorySection()
        case .products:
            return createProductsSection()
        }
    }
}

// MARK: - Layout Section Creation
private extension HomeSectionFactory {
    static func createFeaturedSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.7)))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(.screenHeight / 3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary

        let header = createHeader(size: 80)
        section.boundarySupplementaryItems = [header]
        return section
    }

    static func createCategorySection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.5)))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(.screenHeight / 5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary

        let header = createHeader(size: 50)
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
