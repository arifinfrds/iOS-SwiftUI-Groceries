//
//  GroceriesTimelineProvider.swift
//  GroceriesWidgetExtensionExtension
//
//  Created by arifin on 19/11/24.
//

import WidgetKit

struct GroceriesTimelineProvider: TimelineProvider {
    
    private let placeholderEntry = GroceriesTimelineEntry(date: .now, grocery: "")
    
    private let loader: any GroceryLoader
    
    init(loader: some GroceryLoader) {
        self.loader = loader
    }
    
    func placeholder(in context: Context) -> GroceriesTimelineEntry {
        placeholderEntry
    }
    
    func getSnapshot(in context: Context, completion: @escaping (GroceriesTimelineEntry) -> Void) {
        completion(placeholderEntry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<GroceriesTimelineEntry>) -> Void) {
        Task {
            let entries = try? await loader
                .loadGroceries()
                .map { GroceriesTimelineEntry(date: .now, grocery: $0.name) }
            
            completion(.init(entries: entries ?? [], policy: .atEnd))
        }
    }
}
