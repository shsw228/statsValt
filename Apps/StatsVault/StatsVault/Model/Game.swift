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
    var name: String
    var subTitle: Date
    var icon: String = "doc.questionmark.fill"
    @Relationship(deleteRule: .cascade, inverse: \Song.owner)
    var songs: [Song] = []
    init(name: String, subTitle: Date, songs: [Song] = []) {
        self.name = name
        self.subTitle = subTitle
        self.songs = songs
        
    }
    init(name: String, subTitle: Date, icon: String) {
        self.name = name
        self.subTitle = subTitle
        self.icon = icon
    }

    static var sample: Game {
        return Game(name: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", 
                    subTitle: Date.now)
    }
    
}


