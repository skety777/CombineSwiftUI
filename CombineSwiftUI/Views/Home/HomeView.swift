//
//  HomeView.swift
//  CombineSwiftUI
//
//  Created by Sanket Vaghela on 20/06/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                }
                else if viewModel.products.isEmpty {
                    EmptyStateView()
                } else {
                    List(viewModel.products) { product in
                        NavigationLink {
                            ProductDetailView(product: product)
                        } label: {
                            ProductRowView(product: product)
                        }
                    }
                }
            }
            .navigationTitle("Products")
            .task {
                viewModel.fetchProucts()
            }
        }
    }
}

#Preview {
    HomeView()
}
