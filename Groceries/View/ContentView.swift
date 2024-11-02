import Combine
import SwiftUI

struct ContentView: View {
    
    @State private var newGroceryName: String = ""
    @State private var showAlert = false
    @State private var showDeleteAllAlert = false
    
    @ObservedObject var viewModel: GroceriesViewModel
    
    var body: some View {
        NavigationView {
            List {
                if viewModel.groceries.isEmpty {
                    emptyView
                } else {
                    ForEach(viewModel.groceries) { grocery in
                        Text(grocery.name)
                    }
                    .onDelete(perform: deleteGrocery)
                }
            }
            .navigationTitle("Groceries")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showAlert = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showDeleteAllAlert = true
                    }) {
                        Image(systemName: "trash")
                    }
                }
            }
            .alert("Add Grocery", isPresented: $showAlert, actions: {
                TextField("Grocery name", text: $newGroceryName)
                Button("Add", action: addGrocery)
                    .keyboardShortcut(.defaultAction)
                Button("Cancel", role: .cancel, action: {})
            })
            .alert("Delete All Groceries", isPresented: $showDeleteAllAlert, actions: {
                Text("Are you sure you want to delete all items?")
                Button("Delete", role: .destructive, action: deleteAllGroceries)
                    .keyboardShortcut(.defaultAction)
                Button("Cancel", role: .cancel, action: {})
            })
            .task {
                await viewModel.loadGroceries()
            }
        }
    }
    
    private var emptyView: some View {
        ContentUnavailableView(
            "Empty item",
            systemImage: "cart",
            description: Text("No item found. Tap + button to add items to your groceries list.")
        )
    }
    
    private func addGrocery() {
        guard !newGroceryName.isEmpty else { return }
        Task { @MainActor in
            await viewModel.addGrocery(name: newGroceryName)
            newGroceryName = ""
        }
    }
    
    private func deleteGrocery(at offsets: IndexSet) {
        offsets.forEach { index in
            Task {
                await viewModel.delete(grocery: viewModel.groceries[index])
            }
        }
    }
    
    private func deleteAllGroceries() {
        Task {
            await viewModel.deleteGroceries()
        }
    }
}

//#Preview {
//    ContentView()
//        .modelContainer(for: GroceryItem.self, inMemory: true)
//}
