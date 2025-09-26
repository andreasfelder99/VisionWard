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
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.modelContext) private var context

    var body: some View {
        #if os(macOS)
        splitView
        #else
        if horizontalSizeClass == .regular {
            splitView
        } else {
            tabView
        }
        #endif
    }

    private var splitView: some View {
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
                    AccountDetailsView(context: context)
                case .settings:
                    SettingsView()
                case .none:
                    Text("Select a menu item.")
                }
            }
        }.modelContainer(for: [RiotAccount.self])
    }

    private var tabView: some View {
        TabView {
            AccountDetailsView(context: context)
                .tabItem {
                    Label("Account", systemImage: "person")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }.modelContainer(for: [RiotAccount.self])
    }
}


#Preview {
    ContentView()
}
