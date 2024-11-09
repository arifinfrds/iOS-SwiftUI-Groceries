import AppIntents

// MARK: - App Shortcuts

struct OpenGroceriesShortcut: AppShortcutsProvider {
    
    @AppShortcutsBuilder
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: ShowGroceriesIntent(),
            phrases: [
                "Open \(.applicationName)",
                "See \(.applicationName)",
                "See my \(.applicationName)",
                "What is my \(.applicationName)?",
                "What's my \(.applicationName)?",
                "What is on my \(.applicationName)?",
                "What's on my \(.applicationName)?",
                "Show \(.applicationName)",
                "Show my \(.applicationName)",
                "Show me my \(.applicationName)",
            ],
            shortTitle: LocalizedStringResource(stringLiteral: "Open groceries"),
            systemImageName: "apple.logo"
        )
    }
}
