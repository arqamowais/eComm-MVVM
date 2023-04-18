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
    case invalidURL
}

typealias Handler<T> = (Result<T, DataError>) -> ()

final class APIManager {
   
    static let shared: APIManager = APIManager()
    
    private init() {
        
    }
    
    func request<T: Decodable>(modelType: T.Type, endpointType: EndpointType, completion: @escaping Handler<T>) {
        guard let url = endpointType.url else {
            completion(.failure(.invalidURL))
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
                let result = try JSONDecoder().decode(modelType, from: data)
                completion(.success(result))
            } catch (let error) {
                completion(.failure(.network(error)))
            }
        }.resume()
    }
    
}
