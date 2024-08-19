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
}

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    // Define necessary properties here, such as data models or view models.
    
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
    
    // MARK: - Dependencies
    private var interactor: HomeBusinessLogic & HomeDataStore
    private let router: HomeRoutingLogic
    
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
    
    // Layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeCollectionView.frame = view.bounds
    }
    
    // MARK: - Setup
    private func setup() {
        // Add and configure the collection view
        view.addSubview(homeCollectionView)
        
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
        homeCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
      //  homeCollectionView.collectionViewLayout.invalidateLayout()

    }
    

   
}

// MARK: - HomeDisplayLogic Implement
extension HomeViewController: HomeDisplayLogic {
    // Implement methods defined in the HomeDisplayLogic protocol
}


// MARK: - Section Layout Creation
extension HomeViewController {

    // Featured Section Layout
    static func createFeatured() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.7))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(.screenHeight / 3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
/*
        // Header ekleme
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
*/
        return section
    }


    // Category Section Layout
    static func createCategory() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous // Yatay kayma özelliği
        return section
    }

    // Products Section Layout
    static func createProducts() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging // Yatay kayma özelliği
        return section
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // Return the number of sections based on the SectionType enum
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        // Configure the cell based on the section type
        switch sectionType {
        case .featured:
            cell.contentView.backgroundColor = .red // Featured section cell with red background
        case .category:
            cell.contentView.backgroundColor = .blue // Temporary styling for testing
        case .products:
            cell.contentView.backgroundColor = .green // Temporary styling for testing
        }
        
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    // Implement any necessary delegate methods
}

// MARK: - Preview
#Preview {
    HomeBuilder.build()
}
