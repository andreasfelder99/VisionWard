//
//  ContentView.swift
//  VisionWard
//
//  Created by Andreas Felder on 25.09.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @StateObject private var accountViewModel = AccountViewModel()
    @State private var selection: String?
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                Text("Riot API Test")
                    .tag("RiotAPI")
            }
            .navigationTitle("Main Menu")
            .toolbar {
                ToolbarItem {
                    Button(action: testRiot) {
                        Label("Test Riot", systemImage: "arrow.triangle.2.circlepath")
                    }
                }
            }
        } detail: {
            VStack(alignment: .leading, spacing: 10) {
                if accountViewModel.isLoading {
                    ProgressView("Fetching data...")
                } else if let account = accountViewModel.account {
                    Text("Account Found:")
                        .font(.headline)
                    Text("PUUID: \(account.puuid)")
                    Text("Game Name: \(account.gameName)")
                    Text("Tag Line: \(account.tagLine)")
                } else if let error = accountViewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                } else {
                    Text("Press the button to test the Riot API.")
                }
            }
            .padding()
            .navigationTitle("Details")
        }
    }
    
    private func testRiot() {
        print("riot pressed..")
        accountViewModel.fetchAccount(gameName: "Enze", tagLine: "0001", region: "euw")
    }
}

#Preview {
    ContentView()
}
