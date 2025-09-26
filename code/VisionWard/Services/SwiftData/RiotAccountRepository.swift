//
//  RiotAccountRepository.swift
//  VisionWard
//
//  Created by Andreas Felder on 26.09.2025.
//

import SwiftData
import Foundation

@MainActor
struct RiotAccountRepository: ProfileRepository {
    let context: ModelContext
    
    func saveRiotAccount(riotAccountDTO: RiotAccountDTO) async throws {
        let account = RiotAccount(riotID: riotAccountDTO.puuid, puuid: riotAccountDTO.puuid, tagName: riotAccountDTO.tagLine, regionName: "euw")
        context.insert(account)
        
        try context.save()
    }
    
    func fetchRiotAccount() async throws -> [RiotAccount] {
        let descriptor = FetchDescriptor<RiotAccount>(
            sortBy: [.init(\.puuid)]
        )
        let results = try context.fetch(descriptor)
        return results
    }

}
