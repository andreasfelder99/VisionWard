//
//  SettingsView.swift
//  VisionWard
//
//  Created by Andreas Felder on 25.09.2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("defaultGameName") private var gameName: String = ""
    @AppStorage("defaultTagLine") private var tagLine: String = ""
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Default Riot Account")) {
                    TextField("Game Name (e.g., Enze)", text: $gameName)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    
                    TextField("Tag Line (e.g., 0001)", text: $tagLine)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                }
                
                Section(footer: Text("This account will be used as the default for lookups.")) {}
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}
