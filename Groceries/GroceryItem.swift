import Foundation
import SwiftData

@Model
final class GroceryItem: Identifiable {
    let id = UUID()
    let name: String
    
    init(name: String) {
        self.name = name
    }
}
