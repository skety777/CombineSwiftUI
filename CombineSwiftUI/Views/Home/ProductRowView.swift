//
//  ProductRowView.swift
//  CombineSwiftUI
//
//  Created by Sanket Vaghela on 20/06/25.
//

import SwiftUI

struct ProductRowView: View {
    let product: Product
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: product.image)) { phase in
                if let image = phase.image {
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                } else if phase.error != nil {
                    Image(systemName: "photo")
                        .foregroundColor(.red)
                } else {
                    ProgressView()
                }
            }
            .frame(width: 60, height: 60)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(.headline)
                    .lineLimit(2)
                
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("\(product.rating.rate, specifier: "%.1f")")
                    Text("(\(product.rating.count))")
                        .foregroundColor(.gray)
                }
                .font(.caption)
            }
        }
        .padding(.vertical, 8)
    }
}
