//
//  MenuSelection.swift
//  VisionWard
//
//  Created by Andreas Felder on 25.09.2025.
//

enum MenuSelection: String, CaseIterable, Identifiable {
    case accountDetails = "Account Details"
    case settings = "Settings"

    var id: String { self.rawValue }
}
