//
//  Game.swift
//  StatsVault
//  
//  Created by shsw228 on 2024/04/02
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Game{
    @Attribute(.unique)
    var storedId: String
    var name: String
    
    var createdTime: Date
    var systemIcon: String = "doc.questionmark.fill"
    // プロセカスコア準拠傾斜
    var scoreCalcurateRate: [Double] = [
        1.0,
        0.7,
        0.5,
        0,
        0
    ]
    var difficultyTitle: [String] = ["EASY", "NORMAL", "HARD", "EXPERT", "MASTER"]
    // Gameが削除されたらSongも全て破棄する
    @Relationship(deleteRule: .cascade, inverse: \Song.owner)
    var songs: [Song] = []
    
    var songCount: Int {
        songs.count
    }
    
    init(name: String, songs: [Song] = [], icon: String? = nil) {
        self.storedId = UUID().uuidString
        self.name = name
        self.createdTime = .now
        self.songs = songs
        
        if let icon, !icon.isEmpty {
            self.systemIcon = icon
        }
    }
}


