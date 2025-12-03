//
//  AllProductsView.swift
//  SkincareRoutineTracker
//
//  Created by Pati Bivol on 12/3/25.
//

import SwiftUI

struct Product: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var category: String
}

struct AllProductsView: View {
    @State private var products: [Product] = [
           Product(name: "CeraVe Hydrating Cleanser", category: "Cleanser"),
           Product(name: "Paula's Choice BHA", category: "Exfoliant"),
           Product(name: "Arazlo", category: "Medication"),
           Product(name: "Onexton", category: "Medication"),
           Product(name: "Aquaphor Lip Treatment", category: "Lip Care"),
           Product(name: "Amarte Aqua Veil", category: "Moisturizer"),
           Product(name: "Amarte Exfolipowder", category: "Exfoliant"),
           Product(name: "Dr. Haushka Rose Day Cream", category: "Moisturizer"),
           Product(name: "La Roche-Posay SPF", category: "Sunscreen")
       ]
       
    @State private var showForm = false
       @State private var editingProduct: Product? = nil
       @State private var nameText = ""
       @State private var categoryText = ""
       
       var body: some View {
           NavigationStack {
               List {
                   ForEach(products) { product in
                       NavigationLink(destination: ProductDetailPageView(product: product)) {
                           VStack(alignment: .leading) {
                               Text(product.name)
                                   .font(.headline)
                               Text(product.category)
                                   .font(.subheadline)
                                   .foregroundColor(.gray)
                           }
                       }
                       .swipeActions {
                           Button("Edit") {
                               startEditing(product)
                           }
                           .tint(.blue)
                       }
                   }
                   .onDelete(perform: deleteProducts)
                   .onMove(perform: moveProducts)
               }
               .navigationTitle("My Products")
               .toolbar {
                   ToolbarItem() {
                            EditButton()
                   }
                   
                   ToolbarItem() {
                       Button {
                           startAdding()
                       } label: {
                           Image(systemName: "plus")
                       }
                   }
               }
               .sheet(isPresented: $showForm) {
                   NavigationStack {
                       Form {
                           Section("Product Info") {
                               TextField("Name", text: $nameText)
                               TextField("Category", text: $categoryText)
                           }
                       }
                       .navigationTitle(editingProduct == nil ? "Add Product" : "Edit Product")
                       .toolbar {
                           ToolbarItem(placement: .cancellationAction) {
                               Button("Cancel") {
                                   showForm = false
                               }
                           }
                           ToolbarItem(placement: .confirmationAction) {
                               Button("Save") {
                                   saveProduct()
                               }
                               .disabled(nameText.trimmingCharacters(in: .whitespaces).isEmpty)
                           }
                       }
                   }
               }
           }
       }
       
       // helper functions
       
       func startAdding() {
           editingProduct = nil
           nameText = ""
           categoryText = ""
           showForm = true
       }
       
       func startEditing(_ product: Product) {
           editingProduct = product
           nameText = product.name
           categoryText = product.category
           showForm = true
       }
       
       func saveProduct() {
           let trimmedName = nameText.trimmingCharacters(in: .whitespaces)
           let trimmedCategory = categoryText.trimmingCharacters(in: .whitespaces)
           
           if let editingProduct = editingProduct,
              let index = products.firstIndex(where: { $0.id == editingProduct.id }) {
               // update existing product
               products[index].name = trimmedName
               products[index].category = trimmedCategory
           } else {
               // add new product
               let newProduct = Product(name: trimmedName, category: trimmedCategory)
               products.append(newProduct)
           }
           
           showForm = false
       }
       
       func deleteProducts(at offsets: IndexSet) {
           products.remove(atOffsets: offsets)
       }
       
       func moveProducts(from source: IndexSet, to destination: Int) {
           products.move(fromOffsets: source, toOffset: destination)
       }
   }

   #Preview {
       AllProductsView()
   }

#Preview {
    AllProductsView()
}
