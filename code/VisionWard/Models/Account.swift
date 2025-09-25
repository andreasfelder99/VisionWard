//
//  Account.swift
//  VisionWard
//
//  Created by Andreas Felder on 25.09.2025.
//
import SwiftData

@Model
class Account {
    @Attribute(.unique) var riotID: String
    @Attribute(.unique) var puuid: String
    var tagName: String
    var regionName: String
    
    var favoriteChampionName: String?
    
    init(riotID: String, puuid: String, tagName: String, regionName: String, favoriteChampionName: String? = nil) {
        self.riotID = riotID
        self.puuid = puuid
        self.tagName = tagName
        self.regionName = regionName
        self.favoriteChampionName = favoriteChampionName
    }
    
}
