import SwiftData
import Domain

public final class LocalGroceryDeleter: GroceryDeleter {
    
    private let modelContext: ModelContext
    
    public init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    public func deleteGroceries() async throws {
        let descriptor = FetchDescriptor<GroceryItem>()
        let groceries = try modelContext.fetch(descriptor)
        
        groceries.forEach { grocery in
            modelContext.delete(grocery)
        }
        
        try modelContext.save()
    }
    
    public func delete(grocery: GroceryItem) async throws {
        modelContext.delete(grocery)
        try modelContext.save()
    }
}
