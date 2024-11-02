import SwiftData

final class LocalGroceryLoader: GroceryLoader {
    
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func loadGroceries() async throws -> [GroceryItem] {
        let descriptor = FetchDescriptor<GroceryItem>()
        return try modelContext.fetch(descriptor)
    }
}
