//
//  HomeViewController.swift
//  iBuy
//
//  Created by Baran Baran on 18.08.2024.
//

import UIKit
import FirebaseFirestore

// MARK: - HomeDisplayLogic Protocol
protocol HomeDisplayLogic: AnyObject {
    func displayFetchFeatures(_ viewModel: HomeModels.FetchFeatures.ViewModel)
    func displayFetchProducts(_ viewModel: HomeModels.FetchProducts.ViewModel)
}

// MARK: - HomeViewController
final class HomeViewController: UIViewController {
    
    // MARK:  Properties
    private lazy var features: [FeatureResponse] = []
    private lazy var categories = Category.allCategories
    private lazy var products : [ProductResponse] = []
    
    //MARK: Dependencies
    typealias InteractorType = HomeBusinessLogic & HomeDataStore
    private var interactor: InteractorType
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
    init(interactor: InteractorType, router: HomeRoutingLogic) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchData()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Clear memory to free up resources
        if self.isMovingFromParent || self.isBeingDismissed {
            products.removeAll()
            features.removeAll()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release memory if the view is not visible
        if (self.isViewLoaded) && (self.view.window == nil) {
            self.view = nil
        }
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
        homeCollectionView.register(HomeHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ReuseID.homeHeaderView)
        
        // Invalidate layout
        homeCollectionView.collectionViewLayout.invalidateLayout()
        
    }
    // MARK: - Data Fetching
    private func fetchData(){
        let request =  HomeModels.FetchFeatures.Request()
        interactor.fetchFeatures(request)
    }
}

// MARK: - HomeViewController: HomeDisplayLogic
extension HomeViewController: HomeDisplayLogic {
    func displayFetchFeatures(_ viewModel: HomeModels.FetchFeatures.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.features = viewModel.features
            homeCollectionView.reloadData()
        }
    }
    
    func displayFetchProducts(_ viewModel: HomeModels.FetchProducts.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.products = viewModel.products
            homeCollectionView.reloadData()
        }
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
            return features.count
        case .category:
            return categories.count
        case .products:
            return products.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionType = SectionType(rawValue: indexPath.section) else { return UICollectionViewCell() }
        
        switch sectionType {
        case .featured:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseID.featureCell, for: indexPath) as? FeatureCell else { return UICollectionViewCell() }
            let model = features[safe: indexPath.item]
            cell.configure(with: model)
            return cell
            
        case .category:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseID.categoryCell, for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
            let categoryItem = categories[indexPath.item]
            cell.configure(with: categoryItem)
            return cell
        case .products:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseID.productCell, for: indexPath) as? ProductCell else { return UICollectionViewCell() }
            let productItem = products[safe: indexPath.item]
            cell.configure(with: productItem)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let sectionType = SectionType(rawValue: indexPath.section) else { return UICollectionReusableView() }
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ReuseID.homeHeaderView, for: indexPath) as? HomeHeaderView else { return UICollectionReusableView()}
        
        headerView.headerText = sectionType.sectionTitle
        return headerView
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let sectionType = SectionType(rawValue: indexPath.section) else { return }
        switch sectionType {
        case .featured:
            // Featured item selection logic
            break
        case .category:
            let selectedCategoryName = categories[indexPath.item].name
            let request = HomeModels.FetchProducts.Request(categoryName: selectedCategoryName)
            interactor.fetchProducts(request)
        case .products:
            let selectedProduct = products[indexPath.item]
            interactor.selectedProduct = selectedProduct
            router.routeDetail()
        }
    }
}
