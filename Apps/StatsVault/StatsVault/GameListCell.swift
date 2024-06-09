//
//  GameListCell.swift
//  StatsVault
//
//  Created by shsw228 on 2024/04/02
//

import Foundation
import SwiftUI
import SwiftData

struct GameListCell: View {
    let name: String
    let sub: Date
    let icon: String
    let count: Int
    
    
    var body: some View {
        HStack(spacing: 5) {
            Label(name, systemImage: icon)
                .lineLimit(2)
                .labelStyle(MyLabelStyle())
            Spacer()
            Label(count.description, systemImage: "music.note")
                .labelStyle(MySongInfoLabelStyle())
        }
            
    }
    
    init(game: Game) {
        self.name = game.name
        self.sub = game.createdTime
        self.icon = game.systemIcon
        self.count = game.songs.count
    }
    
    // TODO: 適切なリネーム
    struct MyLabelStyle: LabelStyle {
        func makeBody(configuration: Configuration) -> some View {
            HStack(alignment: .center,spacing: 15) {
                configuration.icon
                    .frame(width: 10)
                    .padding(5)
                configuration.title
            }
        }
    }
    struct MySongInfoLabelStyle: LabelStyle {
        func makeBody(configuration: Configuration) -> some View {
            HStack(alignment: .center, spacing: 5) {
                configuration.icon
                configuration.title
            }
        }
        
        
    }
}
