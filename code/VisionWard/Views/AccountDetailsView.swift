//
//  AccountView.swift
//  VisionWard
//
//  Created by Andreas Felder on 25.09.2025.
//
import SwiftUI
import SwiftData

struct AccountDetailsView: View {
    @State private var accountViewModel = AccountViewModel()
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            if accountViewModel.account == nil {
                    Button("Test Riot API") {
                        Task {
                            await testRiot()
                        }
                    }
            }
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
    }
    
    private func testRiot() async {
        print("riot pressed..")
        await accountViewModel.fetchAccount(gameName: "Enze", tagLine: "0001", region: "euw")
    }
}

#Preview {
    AccountDetailsView()
}
