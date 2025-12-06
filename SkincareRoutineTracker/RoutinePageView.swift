//
//  RoutinePageView.swift
//  SkincareRoutineTracker
//
//  Created by Pati Bivol on 12/1/25.
//

// RoutinePageView.swift

import SwiftUI

enum RoutineKind: String {
    case morning = "Morning Routine"
    case night = "Night Routine"
}

struct RoutinePageView: View {
    
    let kind: RoutineKind
    
    @State private var routineProducts: [Product] = []
    @State private var showAddSheet = false
    
    private let allProducts = ProductManager.shared.loadProducts()
    
    private var routineFileName: String {
        switch kind {
        case .morning:
            return "morningRoutine.json"
        case .night:
            return "nightRoutine.json"
        }
    }
    
    init(kind: RoutineKind = .morning) {
        self.kind = kind
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(routineProducts, id: \.self) { product in
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
                .onDelete(perform: deleteProducts)
                .onMove(perform: moveProducts)
            }
            .navigationTitle(kind.rawValue)
            .toolbar {
                ToolbarItem {
                    EditButton()
                }
                ToolbarItem {
                    Button {
                        showAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddSheet) {
                NavigationStack {
                    List(allProducts, id: \.self) { product in
                        Button {
                            // simplest rule: avoid duplicates in routine
                            if !routineProducts.contains(product) {
                                routineProducts.append(product)
                                saveRoutine()
                            }
                            showAddSheet = false
                        } label: {
                            VStack(alignment: .leading) {
                                Text(product.name)
                                    .font(.headline)
                                Text(product.category)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .navigationTitle("Add to \(kind.rawValue)")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Close") {
                                showAddSheet = false
                            }
                        }
                    }
                }
            }
            .onAppear {
                loadRoutine()
            }
        }
    }
    
    // MARK: - Save / Load routine
    
    private func routineURL() -> URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(routineFileName)
    }
    
    private func loadRoutine() {
        let url = routineURL()
        guard FileManager.default.fileExists(atPath: url.path) else { return }
        
        if let data = try? Data(contentsOf: url),
           let decoded = try? JSONDecoder().decode([Product].self, from: data) {
            routineProducts = decoded
        }
    }
    
    private func saveRoutine() {
        let url = routineURL()
        if let data = try? JSONEncoder().encode(routineProducts) {
            try? data.write(to: url)
        }
    }
    
    // MARK: - List actions
    
    private func deleteProducts(at offsets: IndexSet) {
        routineProducts.remove(atOffsets: offsets)
        saveRoutine()
    }
    
    private func moveProducts(from source: IndexSet, to destination: Int) {
        routineProducts.move(fromOffsets: source, toOffset: destination)
        saveRoutine()
    }
}

#Preview {
    RoutinePageView()   // morning by default
}
