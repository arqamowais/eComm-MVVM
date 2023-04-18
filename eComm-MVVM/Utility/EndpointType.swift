//
//  EndpointType.swift
//  eComm-MVVM
//
//  Created by Arqam Owais on 19/04/2023.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol EndpointType {
    var baseURL: String { get }
    var path: String { get }
    var url: URL? { get }
    var method: HTTPMethod { get }
}

enum EndpointItem {
    case products
}

extension EndpointItem: EndpointType {
    
    var baseURL: String {
        "https://fakestoreapi.com/"
    }
    
    var path: String {
        switch self {
        case .products:
            return "products"
        }
    }
    
    var url: URL? {
        return URL(string: baseURL+path)
    }
    
    var method: HTTPMethod {
        switch self {
        case .products:
            return .get
        }
    }
    
    
}
