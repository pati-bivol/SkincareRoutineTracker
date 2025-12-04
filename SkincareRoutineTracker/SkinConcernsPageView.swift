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
    var focus: String           // main skincare focus
    var suggestedProducts: [String]
    var isSelected: Bool = false
}

struct SkinConcernsPageView: View {    
    @State private var concerns: [SkinConcern] = [
        SkinConcern(
            name: "Acne / Breakouts",
            focus: "Oil control, gentle exfoliation, and non-comedogenic products.",
            suggestedProducts: [
                "Salicylic acid (BHA) cleanser",
                "Niacinamide serum",
                "Lightweight gel moisturizer"
            ]
        ),
        SkinConcern(
            name: "Dryness / Dehydration",
            focus: "Hydration and barrier repair with humectants and ceramides.",
            suggestedProducts: [
                "Hyaluronic acid serum",
                "Ceramide moisturizer",
                "Gentle hydrating cleanser"
            ]
        ),
        SkinConcern(
            name: "Dark Spots / Hyperpigmentation",
            focus: "Brightening and evening skin tone.",
            suggestedProducts: [
                "Vitamin C serum",
                "Niacinamide serum",
                "Daily sunscreen (SPF 30+)"
            ]
        ),
        SkinConcern(
            name: "Redness / Sensitivity",
            focus: "Soothing and barrier-supporting products.",
            suggestedProducts: [
                "Fragrance-free moisturizer",
                "Centella asiatica (cica) cream",
                "Mineral sunscreen"
            ]
        ),
        SkinConcern(
            name: "Dullness / Uneven Texture",
            focus: "Gentle exfoliation and hydration.",
            suggestedProducts: [
                "Lactic acid (AHA) toner",
                "Hydrating serum",
                "Moisturizer with peptides"
            ]
        )
    ]
    
    var selectedConcerns: [SkinConcern] {
        concerns.filter { $0.isSelected }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // Instructions
                    Text("Select the skin concerns that best describe you. We’ll suggest a general skincare focus and product types you might want to include in your routine.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    // Concerns list
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
                    
                    // Suggested focus based on selection
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Suggested Skincare Focus")
                            .font(.headline)
                        
                        if selectedConcerns.isEmpty {
                            Text("Select at least one concern above to see suggestions.")
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
                                    
                                    Text("Suggested product types:")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                    
                                    ForEach(concern.suggestedProducts, id: \.self) { product in
                                        Text("• \(product)")
                                            .font(.subheadline)
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

// Small row view for each concern
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
