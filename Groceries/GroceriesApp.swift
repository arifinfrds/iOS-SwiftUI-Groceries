import SwiftUI
import SwiftData

@main
struct GroceriesApp: App {
    
    static var sharedModelContainer: ModelContainer {
        DataManager.sharedModelContainer
    }

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: makeGroceriesViewModel())
        }
    }
    
    private func makeGroceriesViewModel() -> GroceriesViewModel {
        let modelContext = GroceriesApp.sharedModelContainer.mainContext
        let groceryLoader = LocalGroceryLoader(modelContext: modelContext)
        let groceryDeleter = LocalGroceryDeleter(modelContext: modelContext)
        let groceryAdder = LocalGroceryAdder(modelContext: modelContext)
        return GroceriesViewModel(
            groceryLoader: groceryLoader,
            groceryDeleter: groceryDeleter,
            groceryAdder: groceryAdder
        )
    }
}
