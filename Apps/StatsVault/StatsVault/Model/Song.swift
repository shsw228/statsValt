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
    var createdAt: String
    var owner: Game?
    init(title: String, createdAt: String = Date.now.description, owner: Game) {
        self.title = title
        self.createdAt = createdAt
        self.owner = owner
    }
 }
