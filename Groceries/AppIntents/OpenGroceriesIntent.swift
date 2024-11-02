import AppIntents

struct OpenGroceriesIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Open Groceries list"
    
    static var description = IntentDescription("Opens the app to see groceries list.")
    
    static var openAppWhenRun: Bool = false
    
    @MainActor
    func perform() async throws -> some IntentResult & ProvidesDialog {
        let groceries = [
            GroceryItem(name: "Apples"),
            GroceryItem(name: "Bananas"),
            GroceryItem(name: "Milk")
        ]
        
        var groceryList = groceries
            .map(\.name)
            .joined(separator: ", ")
        groceryList.removeLast()
        
        return .result(dialog: IntentDialog("Your groceries list: \n\(groceryList)"))
    }
}
