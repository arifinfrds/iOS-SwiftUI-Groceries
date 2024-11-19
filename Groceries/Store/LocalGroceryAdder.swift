import SwiftData

final class LocalGroceryAdder: GroceryAdder {
    
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func add(grocery: GroceryItem) async throws {
        modelContext.insert(grocery)
        try modelContext.save()
    }
}
