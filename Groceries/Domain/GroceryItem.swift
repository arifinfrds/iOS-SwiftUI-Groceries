import Foundation
import SwiftData

@Model
public final class GroceryItem: Identifiable {
    public let id = UUID()
    public let name: String
    
    public init(name: String) {
        self.name = name
    }
}
