import AppIntents
import Store

struct RemoveAllGroceriesIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Remove all Grocery items"
    
    static var description: IntentDescription? = IntentDescription(stringLiteral: "Remove all items inside groceries list")
    
    static var openAppWhenRun: Bool = false
    
    @MainActor
    func perform() async throws -> some IntentResult & ProvidesDialog {
        let modelContext = GroceriesApp.sharedModelContainer.mainContext
        let deleter = LocalGroceryDeleter(modelContext: modelContext)
        let loader = LocalGroceryLoader(modelContext: modelContext)
        
        do {
            let groceries = try await loader.loadGroceries()
            
            guard !groceries.isEmpty else {
                let dialog = IntentDialog(stringLiteral: "You don't have any items to be deleted.")
                return .result(dialog: dialog)
            }
            
            do {
                try await deleter.deleteGroceries()
                let count = try await loader.loadGroceries().count
                let dialog = IntentDialog(stringLiteral: "All grocery items are deleted. You have \(count) item.")
                return .result(dialog: dialog)
            } catch {
                throw error
            }
            
        } catch {
            throw error
        }
    }
}
