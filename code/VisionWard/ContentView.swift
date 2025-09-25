//
//  ContentView.swift
//  VisionWard
//
//  Created by Andreas Felder on 25.09.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selection: MenuSelection? = .accountDetails

    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                ForEach(MenuSelection.allCases) { item in
                    NavigationLink(item.rawValue, value: item)
                }
            }
            .navigationTitle("Main Menu")
        } detail: {
            NavigationStack {
                switch selection {
                case .accountDetails:
                    AccountDetailsView()
                case .settings:
                    SettingsView()
                case .none:
                    Text("Select a menu item.")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
