//
//  AddItemToGroceriesIntent.swift
//  Groceries
//
//  Created by arifin on 11/11/24.
//

import AppIntents
import Domain
import Store

struct AddItemToGroceriesIntent: AppIntent {
    
    static var title: LocalizedStringResource = LocalizedStringResource(stringLiteral: "Add item to groceries list")
    
    static var description: IntentDescription? = IntentDescription(stringLiteral: "Add an item to groceries list")
    
    static var openAppWhenRun: Bool = false
    
    @Parameter(title: "Item name")
    var itemName: String?
    
    @MainActor
    func perform() async throws -> some IntentResult & ProvidesDialog {
        
        guard let itemName else {
            let dialog = IntentDialog("What grocery item you would like to add?")
            throw $itemName.needsValueError(dialog)
        }
        
        do {
            let modelContext = GroceriesApp.sharedModelContainer.mainContext
            let adder = LocalGroceryAdder(modelContext: modelContext)
            try await adder.add(grocery: GroceryItem(name: itemName))
            let dialog = IntentDialog("\(itemName) is added to your groceries list")
            return .result(dialog: dialog)
        } catch {
            throw error
        }
    }
}
