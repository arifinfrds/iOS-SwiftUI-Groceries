//
//  GroceryStub.swift
//  GroceriesTests
//
//  Created by arifin on 13/11/24.
//

@testable import Groceries
import Foundation
import Domain

// MARK: - Helpers

final class GroceryStub: GroceryLoader, GroceryDeleter, GroceryAdder {
    
    enum Invocation {
        case loaderGroceries
        case deleteGroceries
        case delete
        case add
    }
    
    private(set) var invocations = [Invocation]()
    
    private let loadGroceriesResult: Result<[GroceryItem], any Error>
    private let deleteGroceriesResult: Result<Void, any Error>
    private let deleteGroceryResult: Result<Void, any Error>
    private let addGroceryResult: Result<Void, any Error>
    
    init(
        loadGroceriesResult: Result<[GroceryItem], any Error> = .failure(NSError()),
        deleteGroceriesResult: Result<Void, any Error> = .failure(NSError()),
        deleteGroceryResult: Result<Void, any Error> = .failure(NSError()),
        addGroceryResult: Result<Void, any Error> = .failure(NSError())
    ) {
        self.loadGroceriesResult = loadGroceriesResult
        self.deleteGroceriesResult = deleteGroceriesResult
        self.deleteGroceryResult = deleteGroceryResult
        self.addGroceryResult = addGroceryResult
    }
    
    // MARK: - GroceryLoader
    
    func loadGroceries() async throws -> [GroceryItem] {
        invocations.append(.loaderGroceries)
        return try loadGroceriesResult.get()
    }
    
    // MARK: - GroceryDeleter
    
    func deleteGroceries() async throws {
        invocations.append(.deleteGroceries)
        switch deleteGroceriesResult {
        case .success:
            break
        case .failure(let error):
            throw error
        }
    }
    
    func delete(grocery: GroceryItem) async throws {
        invocations.append(.delete)
        switch deleteGroceryResult {
        case .success:
            return
        case .failure(let error):
            throw error
        }
    }
    
    // MARK: - GroceryAdder
    
    func add(grocery: GroceryItem) async throws {
        invocations.append(.add)
        switch addGroceryResult {
        case .success:
            return
        case .failure(let error):
            throw error
        }
    }
}
