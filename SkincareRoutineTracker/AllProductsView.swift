//
//  AllProductsView.swift
//  SkincareRoutineTracker
//
//  Created by Pati Bivol on 12/3/25.
//

import SwiftUI

struct AllProductsView: View {
    
    // Load products from JSON (read-only)
    private let products: [Product] = ProductManager.shared.loadProducts()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(products, id: \.self) { product in
                    NavigationLink(destination: ProductDetailPageView(product: product)) {
                        VStack(alignment: .leading) {
                            Text(product.name)
                                .font(.headline)
                            Text(product.category)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("My Products")
        }
    }
}

#Preview {
    AllProductsView()
}
