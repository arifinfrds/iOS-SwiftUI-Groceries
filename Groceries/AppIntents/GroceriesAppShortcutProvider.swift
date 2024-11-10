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
                
                "Show \(.applicationName) from \(.applicationName) app",
                "Show \(.applicationName) item from \(.applicationName) app",
                "Show \(.applicationName) items from \(.applicationName) app",
                "See \(.applicationName) from \(.applicationName) app",
                "See my \(.applicationName) from \(.applicationName) app",
                "What is my \(.applicationName) in \(.applicationName) app?",
                "What's my \(.applicationName) in \(.applicationName) app?",
                "What is my \(.applicationName) list in \(.applicationName) app?",
                "What's my \(.applicationName) list? in \(.applicationName) app",
                "What is on my \(.applicationName) in \(.applicationName) app?",
                "What is on my \(.applicationName) items in \(.applicationName) app?",
                "What is on my \(.applicationName) list in \(.applicationName) app?",
                "What's on my \(.applicationName) in \(.applicationName) app?",
                "What's on my \(.applicationName) items in \(.applicationName) app?",
                "What's on my \(.applicationName) list in \(.applicationName) app?",
                "Show \(.applicationName) from \(.applicationName) app",
                "Show \(.applicationName) list from \(.applicationName) app",
                "Show my \(.applicationName) from \(.applicationName) app",
                "Show my \(.applicationName) list from \(.applicationName) app",
                "Show me my \(.applicationName) from \(.applicationName) app",
                "Show me my \(.applicationName) list from \(.applicationName) app",
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
