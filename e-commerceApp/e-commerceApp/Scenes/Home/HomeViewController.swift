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
        // Create and configure the collection view with a compositional layout
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            // Determine the layout for each section based on the SectionType enum
            guard let sectionType = SectionType(rawValue: sectionIndex) else { return nil }
            
            switch sectionType {
            case .featured:
                return nil // Configure the layout for the featured section
            case .category:
                return nil // Configure the layout for the category section
            case .products:
                return nil // Configure the layout for the products section
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
        layout()
    }
    
    // MARK: - Setup
    private func setup() {
        // Add and configure the collection view
        view.addSubview(homeCollectionView)
        
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
        homeCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    // MARK: - Layout
    private func layout() {
        // Set up constraints for the collection view using SnapKit
        homeCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.snp.trailingMargin).inset(8)
            make.leading.equalTo(view.snp.leadingMargin).offset(8)
            // Consider adding bottom constraint if needed
        }
    }
}

// MARK: - HomeDisplayLogic Implement
extension HomeViewController: HomeDisplayLogic {
    // Implement methods defined in the HomeDisplayLogic protocol
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // Return the number of sections based on the SectionType enum
        return SectionType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return the number of items in each section (temporarily set to 3)
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionType = SectionType(rawValue: indexPath.section) else { return UICollectionViewCell() }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.contentView.backgroundColor = .lightGray // Temporary styling for testing
        
        // Configure the cell based on the section type
        switch sectionType {
        case .featured:
            // Configure the cell for the featured section
            break
        case .category:
            // Configure the cell for the category section
            break
        case .products:
            // Configure the cell for the products section
            break
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
