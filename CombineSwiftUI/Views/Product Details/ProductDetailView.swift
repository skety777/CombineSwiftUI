//
//  File.swift
//  CombineSwiftUI
//
//  Created by Sanket Vaghela on 20/06/25.
//



import SwiftUI

struct ProductDetailView: View {
    @StateObject private var viewModel: ProductDetailViewModel
    
    init(product: Product) {
        _viewModel = StateObject(wrappedValue: ProductDetailViewModel(product: product))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // MARK: - Image Gallery
                imageGallerySection
                
                // MARK: - Product Info
                productInfoSection
                
                // MARK: - Quantity Selector
                quantitySection
                
                // MARK: - Description
                descriptionSection
                
            }
            .padding(.bottom, 80)
        }
        .safeAreaInset(edge: .bottom) {
            addToCartButton
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    // MARK: - Subviews
    
    private var imageGallerySection: some View {
        TabView(selection: $viewModel.selectedImageIndex) {
            ForEach(Array(viewModel.productImages.enumerated()), id: \.offset) { index, image in
                AsyncImage(url: URL(string: image)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .tag(index)
                    case .failure:
                        Image(systemName: "photo")
                            .imageScale(.large)
                    default:
                        ProgressView()
                    }
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .frame(height: 300)
        .background(Color(.systemGroupedBackground))
    }

    
    private var productInfoSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.product.title)
                .font(.title2.bold())
            
            HStack {
                RatingView(rating: viewModel.product.rating)
                Spacer()
                Text(viewModel.formattedPrice)
                    .font(.title3.bold())
                    .foregroundColor(.green)
            }
            
            Text(viewModel.product.category.capitalized)
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal)
    }
    
    private var quantitySection: some View {
        HStack {
            Text("Quantity:")
                .font(.headline)
            
            Stepper(value: $viewModel.selectedQuantity, in: 1...10) {
                Text("\(viewModel.selectedQuantity)")
                    .frame(width: 30)
            }
            
            Spacer()
            
            Text("Total: \(viewModel.formattedPrice)")
                .font(.subheadline.bold())
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
        .padding(.horizontal)
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Description")
                .font(.headline)
            
            Text(viewModel.product.description)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
    }
    
    
    private var addToCartButton: some View {
        Button(action: viewModel.addToCart) {
            Label("Add to Cart", systemImage: "cart")
                .font(.system(size: 17, weight: .bold))
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .padding(.horizontal)
        }
    }
    
}

// MARK: - Helper Views

private struct RatingView: View {
    let rating: Product.Rating
    
    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
            
            Text("\(rating.rate.formatted(.number.precision(.fractionLength(1))))")
                .font(.subheadline.bold())
            
            Text("(\(rating.count))")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

private struct RelatedProductCard: View {
    let product: Product
    
    var body: some View {
        NavigationLink {
            ProductDetailView(product: product)
        } label: {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: product.image)) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(width: 120, height: 120)
                .cornerRadius(8)
                
                Text(product.title)
                    .font(.caption)
                    .lineLimit(2)
                
                Text("$\(product.price.formatted(.number.precision(.fractionLength(2))))")
                    .font(.caption.bold())
            }
            .frame(width: 140)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProductDetailView(product: .mockProduct)
        }
    }
}

extension Product {
    static var mockProduct: Product {
        Product(
            id: 1,
            title: "Premium Leather Wallet",
            price: 49.99,
            description: "Genuine leather wallet with 10 card slots and RFID protection. Perfect for everyday use.",
            category: "accessories",
            image: "https://example.com/wallet.jpg",
            rating: Rating(rate: 4.7, count: 128)
        )
    }
}
