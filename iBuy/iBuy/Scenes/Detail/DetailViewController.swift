//
//  DetailViewController.swift
//  iBuy
//
//  Created by Baran Baran on 3.09.2024.



import UIKit

// MARK: - DetailDisplayLogic Protocol
protocol DetailDisplayLogic: AnyObject {
    func display(viewModel: DetailModels.SaveProduct.ViewModel)
}

// MARK: - DetailViewController
final class DetailViewController: UIViewController{
    
    // MARK:  Properties
    private var product: ProductResponse?

    //MARK:  Dependencies
    typealias InteractorType = DetailBusinessLogic
    private let interactor : InteractorType

    
    // MARK: - UI Elements
    
    private lazy var productView: UIView = {
        let view = ProductView()
        view.configure(with: product)
        view.delegate = self
        return view
    }()
    
    
    // MARK: - İnitialization
    init(interactor: InteractorType, selectedProduct: ProductResponse?) {
        self.interactor = interactor
        self.product = selectedProduct
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        return nil
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        productView.frame = view.bounds
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        if (self.isViewLoaded) && (self.view.window == nil) {
            self.view = nil
        }
    }
    
    // MARK: - Setup
    private func setup() {
        view.addSubview(productView)
    }
}
// MARK: - DetailViewController: ProductViewDelegate
extension DetailViewController: ProductViewDelegate {
    func didTappedAddToCartButton() {
        guard let product = product else { return }
        interactor.saveProduct(
            name: product.name,
            price: product.price,
            url: product.url
        )
    }
}

// MARK: - DetailDisplayLogic
extension DetailViewController: DetailDisplayLogic {
    func display(viewModel: DetailModels.SaveProduct.ViewModel) {
        print(viewModel.successMessage)
    }
}
