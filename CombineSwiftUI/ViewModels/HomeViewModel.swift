//
//  HomeViewModel.swift
//  CombineSwiftUI
//
//  Created by Sanket Vaghela on 20/06/25.
//

import Foundation
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    @Published var products: [Product] = []
    @Published var isLoading = false
    @Published var error: Error? = nil

    
    func fetchProucts() {
        NetworkManager.shared.getData(from: .products)
            .sink { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                default:
                    break
                }
            } receiveValue: { (products:[Product]) in
                self.products = products
            }
            .store(in: &cancellables)
    }
}
