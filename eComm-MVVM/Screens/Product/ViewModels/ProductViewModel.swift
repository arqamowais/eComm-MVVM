//
//  ProductViewModel.swift
//  eComm-MVVM
//
//  Created by Arqam Owais on 18/04/2023.
//

import Foundation

final class ProductViewModel {
    
    var products: [Product] = []
    var eventHandler: ((_ event: Event) -> ())?
    
    func fetchProducts() {
        eventHandler?(.loading)
        
        APIManager.shared.request(modelType: [Product].self, endpointType: EndpointItem.products) { [weak self] resposne in
                guard let self else {
                    return
                }
            self.eventHandler?(.stopLoading)
            switch resposne {
            case .success(let products):
                self.products = products
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }

    }
    
}

extension ProductViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
