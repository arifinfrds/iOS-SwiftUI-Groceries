import AppIntents

struct OpenGroceriesIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Open Groceries list"
    
    static var description = IntentDescription("Opens the app to see groceries list.")
    
    static var openAppWhenRun: Bool = false
    
    @MainActor
    func perform() async throws -> some IntentResult & ProvidesDialog {
        let groceryLoader = LocalGroceryLoader(modelContext: GroceriesApp.sharedModelContainer.mainContext)
        let groceries = try await groceryLoader.loadGroceries()
        
        let groceryList = groceries
            .map(\.name)
            .joined(separator: ", ")
        
        return .result(dialog: IntentDialog("Your groceries list: \n\(groceryList)"))
    }
}
