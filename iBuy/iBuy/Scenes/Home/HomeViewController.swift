//
//  HomeViewController.swift
//  e-commerceApp
//
//  Created by Baran Baran on 18.08.2024.
//

import UIKit

// MARK: - HomeDisplayLogic Protocol
protocol HomeDisplayLogic: AnyObject {
    // Define display methods for updating the UI from the presenter
    // func display(viewModel: HomeModels.Something.ViewModel)
}

// MARK: - SectionType Enum
 enum SectionType: Int, CaseIterable {
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
    private(set) var featuresArray: [FeatureResponse] = []
    
    private var interactor: HomeBusinessLogic & HomeDataStore
    private let router: HomeRoutingLogic
    
    // MARK: - UI Elements
    private lazy var homeCollectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            guard let sectionType = SectionType(rawValue: sectionIndex) else { return nil }
            
            return HomeSectionFactory.buildLayout(for: sectionType)
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
        loadData()
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

// MARK: - HomeDisplayLogic İmplement
extension HomeViewController: HomeDisplayLogic {
    
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
            print(featuresArray.count)
            return featuresArray.count
          

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
            let model = featuresArray[indexPath.item]
            cell.configure(for: model)
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
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ReuseID.headerView, for: indexPath) as? HeaderView else { return UICollectionReusableView()}
        
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


extension HomeViewController {
    // MARK: - Data Loading
    private func loadData() {
        FirebaseService.shared.fetchFeatures { [weak self] result in
            switch result {
            case .success(let data):
                self?.featuresArray = data
                DispatchQueue.main.async {
                    self?.homeCollectionView.reloadData() // Koleksiyon görünümünü yeniden yükle
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
