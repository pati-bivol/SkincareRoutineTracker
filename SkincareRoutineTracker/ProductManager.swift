import Foundation

class ProductManager {
    static let shared = ProductManager()
    private init() {}
    
    func loadProducts() -> [Product] {
        guard let url = Bundle.main.url(forResource: "products", withExtension: "json") else {
            print("Could not find products.json in bundle")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([Product].self, from: data)
        } catch {
            print("Error decoding products.json:", error)
            return []
        }
    }
}
