//
//  GroceryWidgetView.swift
//  GroceriesWidgetExtensionExtension
//
//  Created by arifin on 19/11/24.
//

import WidgetKit
import SwiftUI

struct GroceryWidgetView: View {
    
    let entry: GroceriesTimelineProvider.Entry
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "cart")
                Text("Your grocery list")
            }
            .font(.title3)
            .bold()
            .padding(.bottom, 8)
            
            Text(entry.grocery)
                .font(.caption)
            
            Spacer()
            
            HStack{
                Spacer()
                Text("**Last Update:** \(entry.date.formatted(.dateTime))")
                    .font(.caption2)
                
            }
        }
        .foregroundStyle(.white)
        .containerBackground(for: .widget) {
            Color.cyan
        }
    }
}
