//
//  DataManager.swift
//  Groceries
//
//  Created by arifin on 19/11/24.
//

import SwiftData

public struct DataManager {
    
    private init() {}
    
    static var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            GroceryItem.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
}
