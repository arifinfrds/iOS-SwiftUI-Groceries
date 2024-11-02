protocol GroceryLoader {
    func loadGroceries() async throws -> [GroceryItem]
}
