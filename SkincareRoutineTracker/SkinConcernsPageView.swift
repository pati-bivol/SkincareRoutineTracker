//
//  SkinConcernsPageView.swift
//  SkincareRoutineTracker
//
//  Created by Pati Bivol on 12/1/25.
//

import SwiftUI

struct SkinConcern: Identifiable {
    var id = UUID()
    var name: String
    var focus: String
    var isSelected: Bool = false
}

struct SkinConcernsPageView: View {
    
    // Load all products from JSON
    private let allProducts: [Product] = ProductManager.shared.loadProducts()
    
    @State private var concerns: [SkinConcern] = [
        SkinConcern(
            name: "Acne / Breakouts",
            focus: "Oil control, gentle exfoliation, acne treatments, and non-comedogenic products."
        ),
        SkinConcern(
            name: "Dryness / Dehydration",
            focus: "Hydration, barrier repair, ceramides, and gentle cleansers."
        ),
        SkinConcern(
            name: "Dark Spots / Hyperpigmentation",
            focus: "Brightening products, exfoliation, and daily SPF."
        ),
        SkinConcern(
            name: "Redness / Sensitivity",
            focus: "Soothing ingredients and barrier-supporting creams."
        ),
        SkinConcern(
            name: "Dullness / Uneven Texture",
            focus: "Gentle exfoliation and hydration."
        )
    ]
    
    var selectedConcerns: [SkinConcern] {
        concerns.filter { $0.isSelected }
    }
    
    // MARK: - Recommendation Logic
    func recommendedProducts(for concern: SkinConcern) -> [Product] {
        switch concern.name {
            
        case "Acne / Breakouts":
            return allProducts.filter {
                $0.name.contains("BHA") ||
                $0.name.contains("Onexton") ||
                $0.name.contains("Arazlo")
            }
            
        case "Dryness / Dehydration":
            return allProducts.filter {
                $0.name.contains("Aqua Veil") ||
                $0.name.contains("Rose Day Cream") ||
                $0.name.contains("Hydrating Cleanser")
            }
            
        case "Dark Spots / Hyperpigmentation":
            return allProducts.filter {
                $0.name.contains("BHA") ||
                $0.name.contains("SPF")
            }
            
        case "Redness / Sensitivity":
            return allProducts.filter {
                $0.name.contains("Hydrating Cleanser") ||
                $0.name.contains("Rose Day Cream")
            }
            
        case "Dullness / Uneven Texture":
            return allProducts.filter {
                $0.name.contains("Exfolipowder") ||
                $0.name.contains("BHA")
            }
            
        default:
            return []
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    Text("Select your skin concerns to see personalized product recommendations.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    // MARK: - Concern selection list
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Your Skin Concerns")
                            .font(.headline)
                        
                        ForEach(concerns.indices, id: \.self) { index in
                            ConcernRow(
                                concern: concerns[index],
                                toggleAction: {
                                    concerns[index].isSelected.toggle()
                                }
                            )
                        }
                    }
                    
                    Divider()
                    
                    // MARK: - Recommendations
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Recommended Products")
                            .font(.headline)
                        
                        if selectedConcerns.isEmpty {
                            Text("Select a concern to see personalized product recommendations.")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                        } else {
                            ForEach(selectedConcerns) { concern in
                                VStack(alignment: .leading, spacing: 8) {
                                    
                                    Text(concern.name)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                    
                                    Text(concern.focus)
                                        .font(.subheadline)
                                    
                                    let recs = recommendedProducts(for: concern)
                                    
                                    if recs.isEmpty {
                                        Text("No specific recommendations available.")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    } else {
                                        ForEach(recs, id: \.self) { product in
                                            NavigationLink(destination: ProductDetailPageView(product: product)) {
                                                Text("• \(product.name)")
                                                    .font(.subheadline)
                                            }
                                        }
                                    }
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Skin Concerns")
        }
    }
}

// MARK: - Concern Row
struct ConcernRow: View {
    let concern: SkinConcern
    let toggleAction: () -> Void
    
    var body: some View {
        Button(action: toggleAction) {
            HStack {
                Image(systemName: concern.isSelected ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(concern.isSelected ? .blue : .gray)
                
                Text(concern.name)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            .padding(.vertical, 4)
        }
    }
}

#Preview {
    SkinConcernsPageView()
}
