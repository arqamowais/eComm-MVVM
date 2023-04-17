//
//  ProductListViewController.swift
//  eComm-MVVM
//
//  Created by Arqam Owais on 18/04/2023.
//

import UIKit

final class ProductListViewController: UIViewController {
    
    private var viewModel: ProductViewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
}


extension ProductListViewController {
    private func configure() {
        initViewModel()
        observeEvent()
    }
    
    private func initViewModel() {
        viewModel.fetchProducts()
    }
    
    // Data binding
    private func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else {
                return
            }
            
            switch event {
            case .loading:
                break
            case .stopLoading:
                break
            case .dataLoaded:
                print("")
            case .error(let error):
                break
            }
        }
    }
    
}
