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

