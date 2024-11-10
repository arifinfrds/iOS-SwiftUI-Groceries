struct OpenGroceriesIntentViewModel {
    
    private let groceryLoader: any GroceryLoader
    
    init(groceryLoader: some GroceryLoader) {
        self.groceryLoader = groceryLoader
    }
    
    func perform() async throws -> String {
        let groceries = try await groceryLoader.loadGroceries()
        
        return groceries.isEmpty
        ? "You don't have any groceries"
        : nonEmptyItemsMessage(groceries: groceries)
    }
    
    private func nonEmptyItemsMessage(groceries: [GroceryItem]) -> String {
        let groceryList = groceries
            .map(\.name)
            .joined(separator: ", ")
        
        return "Your groceries list: \n\(groceryList)"
    }
}