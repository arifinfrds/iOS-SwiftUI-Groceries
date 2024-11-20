public protocol GroceryDeleter {
    func deleteGroceries() async throws
    func delete(grocery: GroceryItem) async throws
}
