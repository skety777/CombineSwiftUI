//
//  ProductDetailViewModel.swift
//  CombineSwiftUI
//
//  Created by Sanket Vaghela on 20/06/25.
//

import Foundation
import Combine

final class ProductDetailViewModel: ObservableObject {
    // MARK: - Input
    @Published var selectedQuantity = 1
    
    // MARK: - Output
    @Published private(set) var product: Product
    @Published private(set) var relatedProducts: [Product] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?
    @Published var selectedImageIndex = 0
    
    private var cancellables = Set<AnyCancellable>()
    let productImages: [String]
    
    var currentImage: String {
        productImages[selectedImageIndex]
    }
    
    var formattedPrice: String {
        let total = product.price * Double(selectedQuantity)
        return "$\(total.formatted(.number.precision(.fractionLength(2))))"
    }

    
    // MARK: - Init
    init(product: Product) {
        self.product = product
        self.productImages = [product.image]
    }
    
    func addToCart() {
        
    }
    // MARK: - Private
}
