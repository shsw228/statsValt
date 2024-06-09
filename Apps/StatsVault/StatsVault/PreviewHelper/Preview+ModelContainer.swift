//
//  Preview+ModelContainer.swift
//  StatsVault
//  
//  Created by shsw228 on 2024/05/11
//

import SwiftData

extension ModelContainer {
    static var sample: () throws -> ModelContainer = {
        let schema = Schema([Game.self, Song.self])
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: schema, configurations: config)
        Task { @MainActor in
            Game.insertSampleData(modelContext:container.mainContext)
        }
        return container
    }
}
