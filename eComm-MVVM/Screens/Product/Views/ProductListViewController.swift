//
//  ProductListViewController.swift
//  eComm-MVVM
//
//  Created by Arqam Owais on 18/04/2023.
//

import UIKit

final class ProductListViewController: UIViewController {
    
    @IBOutlet private var productTableView: UITableView!
    
    private var viewModel: ProductViewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
}


extension ProductListViewController {
    
    private func configure() {
        productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        
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
                print("data Loaded")
                DispatchQueue.main.async { [weak self] in
                    guard let self else {
                        return
                    }
                    self.productTableView.reloadData()
                }
            case .error(let error):
                break
            }
        }
    }
    
}


extension ProductListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell else {
            return UITableViewCell()
        }
        let product = viewModel.products[indexPath.row]
        cell.product = product
        return cell
    }
    
}
