import SwiftData
import Domain

public final class LocalGroceryLoader: GroceryLoader {
    
    private let modelContext: ModelContext
    
    public init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    public func loadGroceries() async throws -> [GroceryItem] {
        let descriptor = FetchDescriptor<GroceryItem>()
        return try modelContext.fetch(descriptor)
    }
}
