//
//  CartViewController.swift
//  iBuy
//
//  Created by Baran Baran on 14.09.2024.



import UIKit


protocol CartDisplayLogic: AnyObject {
    func display(viewModel: CartModels.FetchProducts.ViewModel)
}



final class CartViewController: UIViewController{
    
    // MARK: - Properties
    private lazy var products: [ProductDatabase] = []
    
    private var totalPrice: Double {
        return Double(products.reduce(0) { $0 + $1.price })
    }
    
    // MARK: - UI Elements
    
    private lazy var cartCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    
    
    //MARK: - Dependencies
    
    private var interactor : CartBusinessLogic
    
    private let router : CartRoutingLogic
    
    
    // MARK:  İnitialization
    
    init(interactor: CartBusinessLogic, router: CartRoutingLogic) {
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
        fetchProduct()
    }
    
    
    // MARK: - Setup
    private func setup() {
        view.backgroundColor = .systemBackground
        view.addSubview(cartCollectionView)
        cartCollectionView.delegate = self
        cartCollectionView.dataSource = self
        cartCollectionView.register(CartCell.self, forCellWithReuseIdentifier: ReuseID.cartCell)
        cartCollectionView.register(CartHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CartHeaderView")
        
    }
    
    private func layout(){
        cartCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func fetchProduct(){
        interactor.fetchProducts(request: CartModels.FetchProducts.Request())
    }
}


// MARK: - CartDisplayLogic

extension CartViewController: CartDisplayLogic {
    func display(viewModel: CartModels.FetchProducts.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.products = viewModel.products
            cartCollectionView.reloadData()
        }
    }
    
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CartViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(products.count)
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseID.cartCell, for: indexPath) as? CartCell else { return UICollectionViewCell() }
        let product = products[indexPath.item]
        print(product)
        cell.configure(product)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: .screenWidth, height: .screenHeight / 3 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: .screenWidth, height: .screenHeight / 3 )
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CartHeaderView", for: indexPath) as? CartHeaderView else { return UICollectionReusableView() }
            headerView.configure(totalAmount: totalPrice)
            return headerView
        }
        
        return UICollectionReusableView()
    }
    
    
}


#Preview {
    MainVC()
}
