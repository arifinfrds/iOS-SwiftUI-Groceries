//
//  GroceriesViewModelTests.swift
//  GroceriesTests
//
//  Created by arifin on 13/11/24.
//

@testable import Groceries
import XCTest

final class GroceriesViewModelTests: XCTestCase {
    
    // MARK: - init
    
    @MainActor
    func testInit_doesNotPerformAnything() {
        let collaborator = GroceryStub()
        let _ = makeSUT(collaborator: collaborator)
        
        XCTAssertTrue(collaborator.invocations.isEmpty)
    }
    
    // MARK: - loadGroceries
    
    @MainActor
    func testLoadGroceries_performLoaderGroceries() async {
        let collaborator = GroceryStub()
        let sut = makeSUT(collaborator: collaborator)
        
        await sut.loadGroceries()
        
        XCTAssertEqual(collaborator.invocations, [ .loaderGroceries ])
    }
    
    @MainActor
    func testLoadGroceriesTwice_performLoaderGroceriesTwice() async {
        let collaborator = GroceryStub()
        let sut = makeSUT(collaborator: collaborator)
        
        await sut.loadGroceries()
        await sut.loadGroceries()
        
        XCTAssertEqual(collaborator.invocations, [ .loaderGroceries, .loaderGroceries ])
    }
    
    @MainActor
    func testLoadGroceries_whenLoadSuccessfully_deliversEmptyItems() async {
        let expectedGroceries = [GroceryItem]()
        let collaborator = GroceryStub(loadGroceriesResult: .success(expectedGroceries))
        let sut = makeSUT(collaborator: collaborator)
        var receivedGroceries = [GroceryItem]()
        let exp = expectation(description: "Wait for subscription")
        let cancellable = sut.$groceries
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink {
                receivedGroceries = $0
                exp.fulfill()
            }
        
        await sut.loadGroceries()
        await fulfillment(of: [exp], timeout: 0.1)
        
        XCTAssertEqual(receivedGroceries, expectedGroceries)
        cancellable.cancel()
    }
    
    @MainActor
    func testLoadGroceries_whenLoadSuccessfully_deliverItems() async {
        let expectedGroceries = [ GroceryItem(name: "Apple") ]
        let collaborator = GroceryStub(loadGroceriesResult: .success(expectedGroceries))
        let sut = makeSUT(collaborator: collaborator)
        var receivedGroceries = [GroceryItem]()
        let exp = expectation(description: "Wait for subscription")
        let cancellable = sut.$groceries
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink {
                receivedGroceries = $0
                exp.fulfill()
            }
        
        await sut.loadGroceries()
        await fulfillment(of: [exp], timeout: 0.1)
        
        XCTAssertEqual(receivedGroceries, expectedGroceries)
        cancellable.cancel()
    }
    
    // MARK: - deleteGroceries
    
    @MainActor
    func testDeleteGroceries_whenDeleteSuccessfully_performGroceriesDeletionInOrder() async {
        let collaborator = GroceryStub(deleteGroceriesResult: .success(()))
        let sut = makeSUT(collaborator: collaborator)
        
        await sut.deleteGroceries()
        
        XCTAssertEqual(collaborator.invocations, [ .deleteGroceries, .loaderGroceries ])
    }
    
    @MainActor
    func testDeleteGroceries_whenFailedToDelete_doesNotAttemptReload() async {
        let anyError = NSError(domain: "any", code: -1)
        let collaborator = GroceryStub(deleteGroceriesResult: .failure(anyError))
        let sut = makeSUT(collaborator: collaborator)
        
        await sut.deleteGroceries()
        
        XCTAssertEqual(collaborator.invocations, [ .deleteGroceries ])
    }
    
    // MARK: - deleteGrocery
    
    @MainActor
    func testDeleteGrocery_performGroceryDeletionInOrder() async {
        let groceryItem = GroceryItem(name: "a grocery")
        let anyGroceryToDelete = groceryItem
        let collaborator = GroceryStub(
            loadGroceriesResult: .success([groceryItem]),
            deleteGroceryResult: .success(())
        )
        let sut = makeSUT(collaborator: collaborator)
        
        await sut.delete(grocery: anyGroceryToDelete)
        
        XCTAssertEqual(collaborator.invocations, [ .delete, .loaderGroceries ])
    }
    
    @MainActor
    func testDeleteGrocery_whenFailedToDelete_doesNotAttemptReload() async {
        let groceryItem = GroceryItem(name: "a grocery")
        let anyError = NSError(domain: "any", code: -1)
        let collaborator = GroceryStub(deleteGroceryResult: .failure(anyError))
        let sut = makeSUT(collaborator: collaborator)
        
        await sut.delete(grocery: groceryItem)
        
        XCTAssertEqual(collaborator.invocations, [ .delete ])
    }
    
    // MARK: - addGrocery
    
    @MainActor
    func testAddGrocery_performGroceryAdditionInOrder() async {
        let groceryName = "a grocery"
        let collaborator = GroceryStub(loadGroceriesResult: .success([]))
        let sut = makeSUT(collaborator: collaborator)
        
        await sut.addGrocery(name: groceryName)
        
        XCTAssertEqual(collaborator.invocations, [ .add, .loaderGroceries ])
    }
    
    // MARK: - Helpers
    
    @MainActor
    private func makeSUT(
        collaborator: GroceryStub,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> GroceriesViewModel {
        let sut = GroceriesViewModel(
            groceryLoader: collaborator,
            groceryDeleter: collaborator,
            groceryAdder: collaborator
        )
        trackMemoryLeaks(sut, file: file, line: line)
        return sut
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
    
    private let loadGroceriesResult: Result<[GroceryItem], any Error>
    private let deleteGroceriesResult: Result<Void, any Error>
    private let deleteGroceryResult: Result<Void, any Error>
    
    init(
        loadGroceriesResult: Result<[GroceryItem], any Error> = .failure(NSError()),
        deleteGroceriesResult: Result<Void, any Error> = .failure(NSError()),
        deleteGroceryResult: Result<Void, any Error> = .failure(NSError())
    ) {
        self.loadGroceriesResult = loadGroceriesResult
        self.deleteGroceriesResult = deleteGroceriesResult
        self.deleteGroceryResult = deleteGroceryResult
    }
    
    func loadGroceries() async throws -> [GroceryItem] {
        invocations.append(.loaderGroceries)
        return try loadGroceriesResult.get()
    }
    
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
    
    func add(grocery: GroceryItem) async throws {
        invocations.append(.add)
    }
}
