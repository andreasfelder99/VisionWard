//
//  ContentView.swift
//  VisionWard
//
//  Created by Andreas Felder on 25.09.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    @StateObject private var accountViewModel = AccountViewModel()

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Riot API Test")
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem {
                    Button(action: testRiot) {
                        Label("Add Item", systemImage: "plus")
                    }
                    
                    // The button to trigger the API call
                    Button(action: testRiot) {
                        Label("Test Riot", systemImage: "arrow.down.circle")
                    }
                }
            }
        } detail: {
            // Display the API call result in the detail view
            VStack(alignment: .leading, spacing: 10) {
                // Show a progress view while loading
                if accountViewModel.isLoading {
                    ProgressView("Fetching data...")
                }
                
                // Display the fetched account details
                if let account = accountViewModel.account {
                    Text("Account Found:")
                        .font(.headline)
                    Text("PUUID: \(account.puuid)")
                    Text("Game Name: \(account.gameName)")
                    Text("Tag Line: \(account.tagLine)")
                }
                
                // Display error message
                if let error = accountViewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                }
            }
            .padding()
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
    
    private func testRiot() {
        accountViewModel.fetchAccount(gameName: "Enze", tagLine: "0001", region: "euw")
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
