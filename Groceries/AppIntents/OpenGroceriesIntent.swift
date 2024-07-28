import AppIntents

struct OpenGroceriesIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Open Groceries list"
    
    static var description = IntentDescription("Opens the app to see groceries list.")
    
    static var openAppWhenRun: Bool = true
    
    @MainActor
    func perform() async throws -> some IntentResult {
        return .result()
    }
}

import Foundation

// MARK: - App Shortcuts

struct OpenGroceriesShortcut: AppShortcutsProvider {
    
    @AppShortcutsBuilder
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: OpenGroceriesIntent(),
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
