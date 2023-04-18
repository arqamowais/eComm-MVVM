//
//  Product.swift
//  eComm-MVVM
//
//  Created by Arqam Owais on 17/04/2023.
//

import Foundation

struct Product: Decodable {
    let id: Int
    let title: String
    let price: Float
    let description: String
    let category: String
    let image: String
    let rating: Rate
}

struct Rate: Decodable {
    let rate: Float
    let count: Int
}
