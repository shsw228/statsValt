//
//  Song.swift
//  StatsVault
//  
//  Created by shsw228 on 2024/04/15
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Song {
    var title: String
    var createdAt: String = Date.now.description
    var lastEditAt: String = Date.now.description
    var songLevel: Int
    var owner: Game?
    
    var songLebelIcon: Image {
        if songLevel >= 0 && songLevel <= 50 {
            Image(systemName: "\(songLevel).circle")
        } else {
            Image(systemName: "exclamationmark.circle")
        }

        
    }
    init(
        title: String,
        songLebel: Int = 0,
        owner: Game
    ) {
        self.title = title
        self.owner = owner
        self.songLevel = songLebel
        
    }
    
    func update<T>(keyPath: ReferenceWritableKeyPath<Song, T>, to value: T) {
        self[keyPath: keyPath] = value
        lastEditAt = Date.now.description
    }
 }
