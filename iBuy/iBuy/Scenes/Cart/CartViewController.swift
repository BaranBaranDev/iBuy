//
//  CartViewController.swift
//  iBuy
//
//  Created by Baran Baran on 14.09.2024.

import UIKit

// MARK: - CartDisplayLogic Protocol
protocol CartDisplayLogic: AnyObject {
    func displayFetchedProducts(_ viewModel: CartModels.FetchProducts.ViewModel)
    func displayDeleteProductResult(_ viewModel: CartModels.DeleteProduct.ViewModel)
}

// MARK: - CartViewController
final class CartViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var products: [ProductDatabase] = []
    private var interactor: CartBusinessLogic
    
    // MARK: - UI Elements
    private lazy var cartCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    // MARK: - Initialization
    init(interactor: CartBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        return nil
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        fetchProducts()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        if (self.isViewLoaded) && (self.view.window == nil) {
            self.view = nil
            clearMemoryCache()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(
            forName: Notification.Name(ReuseID.notificationName),
            object: nil,
            queue: nil)
        { [weak self] notification in
            guard let self = self else { return }
            self.fetchProducts()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: Notification.Name(ReuseID.notificationName), object: nil)
        clearMemoryCache()
    }
    
    
    // MARK: - Setup
    private func setup() {
        view.backgroundColor = .systemBackground
        view.addSubview(cartCollectionView)
        cartCollectionView.delegate = self
        cartCollectionView.dataSource = self
        cartCollectionView.register(CartCell.self, forCellWithReuseIdentifier: ReuseID.cartCell)
        cartCollectionView.register(CartHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ReuseID.cartHeaderView)
    }
    
    // MARK: - Layout
    private func layout() {
        cartCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Data Fetching
    private func fetchProducts() {
        let request = CartModels.FetchProducts.Request()
        interactor.fetchProducts(request)
    }
    
    // MARK: - Cache Clear
    private func clearMemoryCache() {
        products.removeAll()
        CacheManager.shared.clearCache(includeDisk: true)
    }
}

// MARK: - CartDisplayLogic
extension CartViewController: CartDisplayLogic {
    func displayFetchedProducts(_ viewModel: CartModels.FetchProducts.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.products = viewModel.products
            self.cartCollectionView.reloadData()
        }
    }
    
    func displayDeleteProductResult(_ viewModel: CartModels.DeleteProduct.ViewModel) {
        if viewModel.message.contains("successfully") {
            fetchProducts()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension CartViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseID.cartCell, for: indexPath) as? CartCell else {
            return UICollectionViewCell()
        }
        
        let product = products[indexPath.item]
        cell.configure(with: product)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CartViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: .screenWidth, height: .screenHeight / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: .screenWidth, height: .screenHeight / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader,
           let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ReuseID.cartHeaderView, for: indexPath) as? CartHeaderView {
            headerView.configure(totalAmount: calculateTotalPrice())
            return headerView
        }
        return UICollectionReusableView()
    }
}

// MARK: - UICollectionViewDelegate
extension CartViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeToDelete(_:)))
        swipeGesture.direction = .left
        cell.addGestureRecognizer(swipeGesture)
    }
    
    // MARK:  Swipe To Delete
    @objc fileprivate func handleSwipeToDelete(_ gesture: UISwipeGestureRecognizer) {
        guard let cell = gesture.view as? UICollectionViewCell,
              let indexPath = cartCollectionView.indexPath(for: cell) else { return }
        
        UIView.animate(withDuration: 0.3) {
            cell.backgroundColor = .clear
        }
        
        let productToDelete = products[indexPath.item]
        interactor.deleteProduct(CartModels.DeleteProduct.Request(product: productToDelete))
        
        products.remove(at: indexPath.item)
        cartCollectionView.deleteItems(at: [indexPath])
        
        updateTotalPrice()
    }
    
    // MARK:  Total Price Update
    private func updateTotalPrice() {
        let newTotalPrice = calculateTotalPrice()
        if let headerView = cartCollectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0)) as? CartHeaderView {
            headerView.configure(totalAmount: newTotalPrice)
        }
    }
    
    // MARK:  Calculate Total Price
    private func calculateTotalPrice() -> Double {
        return Double(products.reduce(0) { $0 + $1.price })
    }
}
