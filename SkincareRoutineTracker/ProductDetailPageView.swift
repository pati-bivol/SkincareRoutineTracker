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
        VStack(alignment: .leading, spacing: 16) {
            Text(product.name)
                .font(.title)
                .bold()
            
            Text(product.category)
                .font(.headline)
                .foregroundColor(.gray)
            
            // later: add ingredients + "can / can't mix" sections here
            
            Spacer()
        }
        .padding()
        .navigationTitle("Product Details")
    }
}

#Preview {
    ProductDetailPageView(
        product: Product(name: "Sample Product", category: "Serum")
    )
}
