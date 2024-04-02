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
    @Environment(\.colorScheme) var colorScheme
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for:Game.self)
    }
}
