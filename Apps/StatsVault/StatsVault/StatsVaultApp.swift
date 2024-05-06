//
//  StatsVaultApp.swift
//  StatsVault
//  
//  Created by shsw228 on 2024/04/02
//

import SwiftData
import SwiftUI

@main
struct StatsVaultApp: App {
    @StateObject var defaults = Defaults()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(AppearanceMode(rawValue: defaults.appearance.rawValue)?.colorScheme)
        }
        .modelContainer(for:Game.self)
    }
}
