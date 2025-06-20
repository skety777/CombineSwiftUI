//
//  ErrorView.swift
//  CombineSwiftUI
//
//  Created by Sanket Vaghela on 20/06/25.
//

import SwiftUI

struct ErrorView: View {
    let error: Error
    let retryAction: () -> Void
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundColor(.red)
            Text("Error: \(error.localizedDescription)")
                .padding()
            Button("Retry", action: retryAction)
                .buttonStyle(.borderedProminent)
        }
    }
}
