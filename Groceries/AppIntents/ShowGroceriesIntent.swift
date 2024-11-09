import AppIntents

struct ShowGroceriesIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Show Groceries list"
    
    static var description = IntentDescription("Show current available groceries list item.")
    
    static var openAppWhenRun: Bool = false
    
    @MainActor
    func perform() async throws -> some IntentResult & ProvidesDialog {
        let performResult = try await groceriesResult()
        return .result(dialog: IntentDialog(stringLiteral: performResult))
    }
    
    @MainActor
    private func groceriesResult() async throws -> String {
        let groceryLoader = LocalGroceryLoader(modelContext: GroceriesApp.sharedModelContainer.mainContext)
        let viewModel = OpenGroceriesIntentViewModel(groceryLoader: groceryLoader)
        return try await viewModel.perform()
    }
}
