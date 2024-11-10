import AppIntents

struct GroceriesAppShortcutProvider: AppShortcutsProvider {
    
    @AppShortcutsBuilder
    static var appShortcuts: [AppShortcut] {
        
        AppShortcut(
            intent: ShowGroceriesIntent(),
            phrases: [
                "Show \(.applicationName)",
                "Show \(.applicationName) item",
                "Show \(.applicationName) items",
                "See \(.applicationName)",
                "See my \(.applicationName)",
                "What is my \(.applicationName)?",
                "What's my \(.applicationName)?",
                "What is my \(.applicationName) list?",
                "What's my \(.applicationName) list?",
                "What is on my \(.applicationName)?",
                "What is on my \(.applicationName) items?",
                "What is on my \(.applicationName) list?",
                "What's on my \(.applicationName)?",
                "What's on my \(.applicationName) items?",
                "What's on my \(.applicationName) list?",
                "Show \(.applicationName)",
                "Show \(.applicationName) list",
                "Show my \(.applicationName)",
                "Show my \(.applicationName) list",
                "Show me my \(.applicationName)",
                "Show me my \(.applicationName) list",
            ],
            shortTitle: LocalizedStringResource(stringLiteral: "Show groceries"),
            systemImageName: "cart"
        )
        
        AppShortcut(
            intent: RemoveAllGroceriesIntent(),
            phrases: [
                "Remove all \(.applicationName)",
                "Empty all \(.applicationName)",
                "Remove my \(.applicationName)",
                "Empty all of my \(.applicationName)",
                "Remove my \(.applicationName) items",
                "Delete all items in my \(.applicationName)",
                "Delete all of my \(.applicationName) items",
                "Remove all items in my \(.applicationName)",
                "Empty all items in my \(.applicationName)",
                "Set my \(.applicationName) items to zero",
            ],
            shortTitle: LocalizedStringResource(stringLiteral: "Remove all groceries"),
            systemImageName: "cart.fill.badge.minus"
        )
    }
}
