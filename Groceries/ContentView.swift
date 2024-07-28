import SwiftUI
import SwiftData


struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var groceries: [GroceryItem]
    @State private var newGroceryName: String = ""
    @State private var showAlert = false
    @State private var showDeleteAllAlert = false
    
    var body: some View {
        NavigationView {
            List {
                if groceries.isEmpty {
                    emptyView
                } else {
                    ForEach(groceries) { grocery in
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
        let newItem = GroceryItem(name: newGroceryName)
        modelContext.insert(newItem)
        newGroceryName = ""
    }
    
    private func deleteGrocery(at offsets: IndexSet) {
        offsets.forEach { index in
            modelContext.delete(groceries[index])
        }
    }
    
    private func deleteAllGroceries() {
        groceries.forEach { grocery in
            modelContext.delete(grocery)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: GroceryItem.self, inMemory: true)
}
