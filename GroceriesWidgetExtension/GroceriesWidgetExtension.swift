//
//  GroceriesWidgetExtension.swift
//  GroceriesWidgetExtensionExtension
//
//  Created by arifin on 19/11/24.
//

import SwiftUI
import WidgetKit

@main
struct GroceriesWidgetExtension: Widget {
    
    let kind: String = "GroceriesWidgetExtension-list"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: makeGroceriesTimelineProvider(),
            content: { GroceryWidgetView(entry: $0) }
        )
        .configurationDisplayName("Show Groceries list")
        .description("Show current available groceries list item.")
        .supportedFamilies([
            .systemMedium,
            .systemLarge
        ])
    }
    
    private func makeGroceriesTimelineProvider() -> GroceriesTimelineProvider {
        let modelContext = DataManager.sharedModelContainer.mainContext
        let loader = LocalGroceryLoader(modelContext: modelContext)
        return GroceriesTimelineProvider(loader: loader)
    }
}

#Preview(as: .systemMedium) {
    GroceriesWidgetExtension()
} timeline: {
    GroceriesTimelineEntry(date: .now, grocery: "Item 1, Item 2, Item 3")
}

#Preview(as: .systemLarge) {
    GroceriesWidgetExtension()
} timeline: {
    GroceriesTimelineEntry(date: .now, grocery: "Item 1, Item 2, Item 3")
}
