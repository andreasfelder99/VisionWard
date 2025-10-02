//
//  AccountView.swift
//  VisionWard
//
//  Created by Andreas Felder on 25.09.2025.
//
import SwiftUI
import SwiftData

struct AccountDetailsView: View {
    @State private var accountViewModel: AccountViewModel
    
    @AppStorage("defaultGameName") private var gameName: String = ""
    @AppStorage("defaultTagLine") private var tagLine: String = ""
    
    @State private var isShowingSettings = false
    
    private var isDefaultAccountSet: Bool {
        !gameName.isEmpty && !tagLine.isEmpty
    }
    
    init(context: ModelContext) {
        let repository = RiotAccountRepository(context: context)
        _accountViewModel = State(initialValue: AccountViewModel(repository: repository))
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 20) {
                if accountViewModel.isLoading {
                    ProgressView("Looking up \(gameName)#\(tagLine)...")
                } else if let account = accountViewModel.account {
                    Text("Account Found:")
                        .font(.headline)
                    Text("Game Name: \(account.gameName)")
                    Text("PUUID: \(account.puuid)")
                    Text("Tag Line: \(account.tagLine)")
                    Spacer()
                } else if let error = accountViewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                    Spacer()
                } else {
                    Spacer()
                    if isDefaultAccountSet {
                        Text("Ready to look up default account:")
                        Text("\(gameName) #\(tagLine)")
                            .font(.title2)
                            .fontWeight(.bold)
                    } else {
                        Text("No default account set.")
                            .foregroundColor(.secondary)
                        Text("Please tap the gear icon to set it.")
                    }
                    Spacer()
                }
                
                Button(isDefaultAccountSet ? "Lookup Default Account" : "Set Default Account") {
                    if isDefaultAccountSet {
                        Task {
                            await lookupDefaultAccount()
                        }
                    } else {
                        isShowingSettings = true
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(accountViewModel.isLoading)
                .disabled(isDefaultAccountSet ? false : false)

            }
            .padding()
            .navigationTitle("Account Lookup")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingSettings = true
                    } label: {
                        Image(systemName: "gear")
                    }
                }
            }
            .sheet(isPresented: $isShowingSettings) {
                SettingsView()
            }
        }
    }
    
    private func lookupDefaultAccount() async {
        guard isDefaultAccountSet else { return }
        print("Looking up \(gameName)#\(tagLine)...")
        await accountViewModel.fetchAccount(gameName: gameName, tagLine: tagLine, region: "euw")
    }
}
