import Foundation
import SwiftData

@Model
public final class GroceryItem: Identifiable {
    public var id = UUID()
    public var name: String
    
    public init(name: String) {
        self.name = name
    }
}
