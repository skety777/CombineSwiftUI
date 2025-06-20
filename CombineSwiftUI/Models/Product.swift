//
//  Product.swift
//  CombineSwiftUI
//
//  Created by Sanket Vaghela on 20/06/25.
//

import Foundation

struct Product: Decodable, Identifiable, Hashable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating

    struct Rating: Decodable, Hashable {
        let rate: Double
        let count: Int
    }
}
