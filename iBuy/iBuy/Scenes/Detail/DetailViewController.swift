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


    //MARK:  Dependencies
    private let interactor : DetailBusinessLogic & DetailDataStore
    private let router : DetailRoutingLogic

    
    // MARK: - UI Elements
    
    private let productView: UIView = {
        return ProductView()
    }()
    
    
    // MARK: - İnitialization
    
    init(interactor: DetailBusinessLogic & DetailDataStore, router: DetailRoutingLogic) {
        self.interactor = interactor
        self.router = router
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



#Preview {
    DetailBuilder.build()
}
