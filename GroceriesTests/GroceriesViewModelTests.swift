//
//  GroceriesViewModelTests.swift
//  GroceriesTests
//
//  Created by arifin on 13/11/24.
//

@testable import Groceries
import XCTest

final class GroceriesViewModelTests: XCTestCase {
    
    @MainActor
    func testInit_doesNotPerformAnything() {
        let collaborator = GroceryStub()
        _ = GroceriesViewModel(
            groceryLoader: collaborator,
            groceryDeleter: collaborator,
            groceryAdder: collaborator
        )
        
        XCTAssertTrue(collaborator.invocations.isEmpty)
    }
}

// MARK: - Helpers

private final class GroceryStub: GroceryLoader, GroceryDeleter, GroceryAdder {
    
    enum Invocation {
        case loaderGroceries
        case deleteGroceries
        case delete
        case add
    }
    
    private(set) var invocations = [Invocation]()
    
    func loadGroceries() async throws -> [GroceryItem] {
        invocations.append(.loaderGroceries)
        return []
    }
    
    func deleteGroceries() async throws {
        invocations.append(.deleteGroceries)
    }
    
    func delete(grocery: GroceryItem) async throws {
        invocations.append(.delete)
    }
    
    func add(grocery: GroceryItem) async throws {
        invocations.append(.add)
    }
}
