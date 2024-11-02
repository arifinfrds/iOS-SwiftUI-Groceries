import SwiftData

final class LocalGroceryDeleter: GroceryDeleter {
    
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func deleteGroceries() async throws {
        let descriptor = FetchDescriptor<GroceryItem>()
        let groceries = try modelContext.fetch(descriptor)
        
        groceries.forEach { grocery in
            modelContext.delete(grocery)
        }
        
        try modelContext.save()
    }
    
    func delete(grocery: GroceryItem) async throws {
        modelContext.delete(grocery)
        try modelContext.save()
    }
}
