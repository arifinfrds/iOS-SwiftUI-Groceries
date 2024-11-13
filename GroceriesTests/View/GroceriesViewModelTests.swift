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
    
    init(
        loadGroceriesResult: Result<[GroceryItem], any Error> = .failure(NSError())
    ) {
        self.loadGroceriesResult = loadGroceriesResult
    }
    
    func loadGroceries() async throws -> [GroceryItem] {
        invocations.append(.loaderGroceries)
        return try loadGroceriesResult.get()
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
