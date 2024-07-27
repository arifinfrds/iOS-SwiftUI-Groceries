import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var groceries: [GroceryItem]
    @State private var newGroceryName: String = ""
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(groceries) { grocery in
                    Text(grocery.name)
                }
                .onDelete(perform: removeGrocery)
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
                        removeAllGroceries()
                    }) {
                        Image(systemName: "trash")
                    }
                }
            }
            .alert("Add Grocery", isPresented: $showAlert, actions: {
                TextField("Grocery name", text: $newGroceryName)
                Button("Add", action: addGrocery)
                Button("Cancel", role: .cancel, action: {})
            })
        }
    }
    
    private func addGrocery() {
        guard !newGroceryName.isEmpty else { return }
        let newItem = GroceryItem(name: newGroceryName)
        modelContext.insert(newItem)
        newGroceryName = ""
    }
    
    private func removeGrocery(at offsets: IndexSet) {
        offsets.forEach { index in
            modelContext.delete(groceries[index])
        }
    }
    
    private func removeAllGroceries() {
        groceries.forEach { grocery in
            modelContext.delete(grocery)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: GroceryItem.self, inMemory: true)
}
