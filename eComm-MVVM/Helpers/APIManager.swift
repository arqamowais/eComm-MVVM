//
//  APIManager.swift
//  eComm-MVVM
//
//  Created by Arqam Owais on 18/04/2023.
//

import Foundation

enum DataError: Error {
    case invalidResponse
    case invalidData
    case invalidDecoding
    case network(Error?)
}

typealias Handler = (Result<[Product], DataError>) -> ()

final class APIManager {
   
    static let shared: APIManager = APIManager()
    
    private init() {
        
    }
    
    func fetchProducts(completion: @escaping Handler) {
        guard let url = URL(string: Constant.API.productURL) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(products))
            } catch (let error) {
                completion(.failure(.network(error)))
            }
        }.resume()
    }
    
}
