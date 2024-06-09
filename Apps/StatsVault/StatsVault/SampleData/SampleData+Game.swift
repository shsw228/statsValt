//
//  SampleData+Game.swift
//  StatsVault
//  
//  Created by shsw228 on 2024/05/11
//

import Foundation
import SwiftData

extension Game {
    static let japanese_short = Game(name: "短いゲームタイトル")
    static let japanese_long = Game(name: "長いゲームタイトル長いゲームタイトル")
    static let english_short = Game(name: "short-game-title")
    static let english_long = Game(name: "long-long-long-game-title")
    
    
    static func insertSampleData(modelContext: ModelContext) {
        modelContext.insert(japanese_short)
        modelContext.insert(japanese_long)
        modelContext.insert(english_long)
        modelContext.insert(english_short)
        
        modelContext.insert(Song.japanese_long)
        modelContext.insert(Song.japanese_short)
        modelContext.insert(Song.english_long)
        modelContext.insert(Song.english_short)
        
        
        Song.japanese_short.owner = japanese_short
        Song.japanese_long.owner = japanese_long
        Song.english_short.owner = english_short
        Song.english_long.owner = english_long
        
        
        
    }
}
