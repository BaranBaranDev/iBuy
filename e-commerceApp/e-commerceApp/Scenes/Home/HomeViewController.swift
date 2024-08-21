//
//  HomeViewController.swift
//  e-commerceApp
//
//  Created by Baran Baran on 18.08.2024.
//

import UIKit
import SnapKit

// MARK: - HomeDisplayLogic Protocol
protocol HomeDisplayLogic: AnyObject {
    // Define display methods for updating the UI from the presenter
    // func display(viewModel: HomeModels.Something.ViewModel)
}

// MARK: - SectionType Enum
private enum SectionType: Int, CaseIterable {
    case featured = 0
    case category = 1
    case products = 2
    
    var sectionTitle: String {
        switch self {
        case .featured:
            return "Featured"
        case .category:
            return "Category"
        case .products:
            return "Products"
        }
    }
}

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    private var interactor: HomeBusinessLogic & HomeDataStore
    private let router: HomeRoutingLogic
    
    // MARK: - UI Elements
    private lazy var homeCollectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            guard let sectionType = SectionType(rawValue: sectionIndex) else { return nil }
            
            switch sectionType {
            case .featured:
                return HomeViewController.createFeatured()
            case .category:
                return HomeViewController.createCategory()
            case .products:
                return HomeViewController.createProducts()
            }
        }
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    // MARK: - Initialization
    init(interactor: HomeBusinessLogic & HomeDataStore, router: HomeRoutingLogic) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeCollectionView.frame = view.bounds
    }
    
    // MARK: - Setup
    private func setup() {
        view.addSubview(homeCollectionView)
        
        // Configure CollectionView
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
        homeCollectionView.register(FeatureCell.self, forCellWithReuseIdentifier: ReuseID.featureCell)
        homeCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: ReuseID.categoryCell)
        homeCollectionView.register(ProductCell.self, forCellWithReuseIdentifier: ReuseID.productCell)
        homeCollectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ReuseID.headerView)
        
        // Invalidate layout
        homeCollectionView.collectionViewLayout.invalidateLayout()
    }
}

extension HomeViewController: HomeDisplayLogic {
    
}

// MARK: - Section Layout Creation
private extension HomeViewController {
    
    static func createFeatured() -> NSCollectionLayoutSection? {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.9),
                heightDimension: .fractionalHeight(0.7)
            )
        )
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .absolute(.screenHeight / 3)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(80)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    static func createCategory() -> NSCollectionLayoutSection? {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .fractionalHeight(0.5)
            )
        )
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .absolute(.screenHeight / 5)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(50)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    static func createProducts() -> NSCollectionLayoutSection? {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(0.9)
            )
        )
        item.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(0.3)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(45)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        return section
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionType = SectionType(rawValue: section) else { return 0 }
        
        switch sectionType {
        case .featured:
            return 3
        case .category:
            return 5
        case .products:
            return 7
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionType = SectionType(rawValue: indexPath.section) else { return UICollectionViewCell() }
        
        switch sectionType {
        case .featured:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseID.featureCell, for: indexPath) as? FeatureCell else { return UICollectionViewCell() }
            return cell
        case .category:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseID.categoryCell, for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
            return cell
        case .products:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseID.productCell, for: indexPath) as? ProductCell else { return UICollectionViewCell() }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let sectionType = SectionType(rawValue: indexPath.section) else { return UICollectionReusableView() }
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ReuseID.headerView, for: indexPath) as! HeaderView
        
        headerView.headerText = sectionType.sectionTitle
        return headerView
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    // Implement necessary delegate methods if needed
}

// MARK: - Preview
#Preview {
    HomeBuilder.build()
}
