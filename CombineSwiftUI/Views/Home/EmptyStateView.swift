//
//  EmptyView.swift
//  CombineSwiftUI
//
//  Created by Sanket Vaghela on 20/06/25.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack {
            Image(systemName: "bag.fill")
                .font(.largeTitle)
                .foregroundColor(.gray)
            Text("No products available")
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
}
