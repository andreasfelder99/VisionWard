//
//  ProfileRepository.swift
//  VisionWard
//
//  Created by Andreas Felder on 26.09.2025.
//

protocol ProfileRepository {
    func saveRiotAccount(riotAccountDTO: RiotAccountDTO) async throws
    func fetchRiotAccount() async throws -> [RiotAccount]
}
