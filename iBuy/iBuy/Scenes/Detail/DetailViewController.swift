//
//  DetailViewController.swift
//  iBuy
//
//  Created by Baran Baran on 3.09.2024.



import UIKit


protocol DetailDisplayLogic: AnyObject {
    
   // func display(viewModel: DetailModels.Something.ViewModel)
}



final class DetailViewController: UIViewController{
    
    // MARK:  Properties
    private var product: ProductResponse?

    //MARK:  Dependencies
    typealias InteractorType = DetailBusinessLogic & DetailDataStore
    private let interactor : InteractorType
    private let router : DetailRoutingLogic

    
    // MARK: - UI Elements
    
    private lazy var productView: UIView = {
        let view = ProductView()
        view.configure(with: product)
        view.delegate = self
        return view
    }()
    
    
    // MARK: - İnitialization
    
    init(interactor: InteractorType, router: DetailRoutingLogic, selectedProduct: ProductResponse?) {
        self.interactor = interactor
        self.router = router
        self.product = selectedProduct
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        productView.frame = view.bounds
    }
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()   
    }
 
    
    // MARK: - Setup
    private func setup() {
        view.addSubview(productView)
        
       
    }
    
    // MARK: Layout
    private func layout() {
        
    }
}


// MARK: - DetailDisplayLogic

extension DetailViewController: DetailDisplayLogic {

}

extension DetailViewController: ProductViewDelegate {
    func didTappedAddToCartButton() {
        print("Click: $\(product?.name)")
    }
}



#Preview {
    MainVC()
}
