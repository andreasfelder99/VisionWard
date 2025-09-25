//
// NetworkService.swift
// VisionWard
//
// Created by Andreas Felder on 25.09.2025.
//

import Foundation

class RiotAPIService {
    private let session = URLSession.shared
    private var _apiKey: String?
    
    // A computed property that handles retrieval and caching
    var apiKey: String {
        // If the key has already been loaded, return it
        if let key = _apiKey {
            return key
        }
        
        // Otherwise, attempt to load it and handle errors
        do {
            let key = try getAPIKey()
            _apiKey = key // Store the key for future use
            return key
        } catch {
            fatalError("Failed to retrieve API key: \(error.localizedDescription)")
        }
    }
    
    func getAccountByRiotID(gameName: String, tagLine: String, region: String) async throws -> RiotAccount {
        let regionalRouting = "europe"
        
        let urlString = "https://\(regionalRouting).api.riotgames.com/riot/account/v1/accounts/by-riot-id/\(gameName)/\(tagLine)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-Riot-Token")
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let account = try JSONDecoder().decode(RiotAccount.self, from: data)
        return account
    }
}

func getAPIKey() throws -> String {
    guard let path = Bundle.main.path(forResource: "secrets", ofType: "plist") else {
        throw NSError(domain: "MyAppError", code: 404, userInfo: [NSLocalizedDescriptionKey: "secrets.plist not found."])
    }

    guard let dict = NSDictionary(contentsOfFile: path) as? [String: Any] else {
        throw NSError(domain: "MyAppError", code: 500, userInfo: [NSLocalizedDescriptionKey: "Could not load dictionary from secrets.plist."])
    }
    
    guard let apiKey = dict["api_key_riot"] as? String else {
        throw NSError(domain: "MyAppError", code: 500, userInfo: [NSLocalizedDescriptionKey: "APIKey not found or is not a String."])
    }
    
    return apiKey
}
