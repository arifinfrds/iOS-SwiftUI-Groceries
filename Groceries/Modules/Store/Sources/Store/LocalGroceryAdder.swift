import SwiftData
import Domain

public final class LocalGroceryAdder: GroceryAdder {
    
    private let modelContext: ModelContext
    
    public init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    public func add(grocery: GroceryItem) async throws {
        modelContext.insert(grocery)
        try modelContext.save()
    }
}
