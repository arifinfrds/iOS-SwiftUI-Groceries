import Combine

@MainActor
final class GroceriesViewModel: ObservableObject {
    
    private let groceryLoader: any GroceryLoader
    private let groceryDeleter: any GroceryDeleter
    private let groceryAdder: any GroceryAdder
    
    @Published var groceries = [GroceryItem]()
    
    init(
        groceryLoader: some GroceryLoader,
        groceryDeleter: some GroceryDeleter,
        groceryAdder: some GroceryAdder
    ) {
        self.groceryLoader = groceryLoader
        self.groceryDeleter = groceryDeleter
        self.groceryAdder = groceryAdder
    }
    
    func loadGroceries() async {
        groceries = (try? await groceryLoader.loadGroceries()) ?? []
    }
    
    func deleteGroceries() async {
        do {
            try await groceryDeleter.deleteGroceries()
            await reloadGroceries()
        } catch {
            print("deleteGroceries failed")
        }
    }
    
    func delete(grocery: GroceryItem) async {
        do {
            try await groceryDeleter.delete(grocery: grocery)
            await reloadGroceries()
        } catch {
            print("deleteGrocery failed")
        }
    }
    
    func addGrocery(name newGroceryName: String) async {
        do {
            let newItem = GroceryItem(name: newGroceryName)
            try await groceryAdder.add(grocery: newItem)
            await reloadGroceries()
        } catch {
            print("addGrocery failed")
        }
    }
    
    private func reloadGroceries() async {
        await loadGroceries()
    }
}
