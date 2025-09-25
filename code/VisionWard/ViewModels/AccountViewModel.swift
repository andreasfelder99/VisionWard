//
//  AccountViewModel.swift
//  VisionWard
//
//  Created by Andreas Felder on 25.09.2025.
//

// ViewModel.swift

import Foundation
import SwiftUI

@Observable
final class AccountViewModel {
    private let riotAPIService = RiotAPIService()
    
    var account: RiotAccount?
    var isLoading = false
    var errorMessage: String?

    init(account: RiotAccount? = nil, isLoading: Bool = false, errorMessage: String? = nil) {
        self.account = account
        self.isLoading = isLoading
        self.errorMessage = errorMessage
    }
    
    func fetchAccount(gameName: String, tagLine: String, region: String) async {
        isLoading = true
        errorMessage = nil
        
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

