import AppIntents

struct OpenGroceriesIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Open Groceries list"
    
    static var description = IntentDescription("Opens the app to see groceries list.")
    
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
