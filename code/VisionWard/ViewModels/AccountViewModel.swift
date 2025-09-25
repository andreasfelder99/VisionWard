//
//  AccountViewModel.swift
//  VisionWard
//
//  Created by Andreas Felder on 25.09.2025.
//

// ViewModel.swift

import Foundation
import SwiftUI
internal import Combine

@MainActor
class AccountViewModel: ObservableObject {
    private let riotAPIService = RiotAPIService()
    
    @Published var account: RiotAccount?
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchAccount(gameName: String, tagLine: String, region: String) {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let fetchedAccount = try await riotAPIService.getAccountByRiotID(gameName: gameName, tagLine: tagLine, region: region)
                self.account = fetchedAccount
            } catch {
                self.errorMessage = error.localizedDescription
                print("Error fetching account: \(error)")
            }
            isLoading = false
        }
    }
}
