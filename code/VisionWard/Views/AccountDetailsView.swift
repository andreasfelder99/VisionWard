//
//  AccountView.swift
//  VisionWard
//
//  Created by Andreas Felder on 25.09.2025.
//
import SwiftUI

struct AccountDetailsView: View {
    @StateObject private var accountViewModel = AccountViewModel()
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            if accountViewModel.account == nil {
                    Button("Test Riot API") {
                        testRiot()
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
    
    private func testRiot() {
        print("riot pressed..")
        accountViewModel.fetchAccount(gameName: "Enze", tagLine: "0001", region: "euw")
    }
}

#Preview {
    AccountDetailsView()
}
