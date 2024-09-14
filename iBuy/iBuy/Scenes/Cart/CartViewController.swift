//
//  CartViewController.swift
//  iBuy
//
//  Created by Baran Baran on 14.09.2024.



import UIKit


protocol CartDisplayLogic: AnyObject {
    
   // func display(viewModel: CartModels.Something.ViewModel)
}



final class CartViewController: UIViewController{

    // MARK: - Properties
    
    
    // MARK: - UI Elements
    

    //MARK: - Dependencies

    private var interactor : CartBusinessLogic & CartDataStore
    
    private let router : CartRoutingLogic

    
    // MARK:  İnitialization
    
    init(interactor: CartBusinessLogic & CartDataStore, router: CartRoutingLogic) {
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
        
    }
    
    // MARK: Layout
    private func layout() {
        
    }
}


// MARK: - CartDisplayLogic

extension CartViewController: CartDisplayLogic {

}
