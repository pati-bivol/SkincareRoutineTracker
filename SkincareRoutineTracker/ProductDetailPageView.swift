//
//  ProductDetailPageView.swift
//  SkincareRoutineTracker
//
//  Created by Pati Bivol on 12/1/25.
//

import SwiftUI

struct ProductDetailPageView: View {
    let product: Product
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Product Name
                Text(product.name)
                    .font(.title)
                    .bold()
                
                // Category
                Text(product.category)
                    .font(.headline)
                    .foregroundColor(.gray)
                
                Divider()
                
                // Description
                Text("Description")
                    .font(.title3)
                    .bold()
                
                Text(product.description)
                    .font(.body)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Product Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ProductDetailPageView(
        product: Product(
            name: "CeraVe Hydrating Cleanser",
            category: "Cleanser",
            description: "A gentle cleanser used to remove dirt and oil without stripping the skin barrier."
        )
    )
}
