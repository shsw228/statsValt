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
        HStack(spacing:5) {
            Label(name, systemImage: icon)
                .lineLimit(2)
                .labelStyle(MyLabelStyle())
            HStack() {
                Image(systemName: "music.note")
                Text(count.description)
            }
        }
            
    }
    
    init(game: Game) {
        self.name = game.name
        self.sub = game.subTitle
        self.icon = game.icon
        self.count = game.songs.count
    }
    
    // TODO: 適切なリネーム
    struct MyLabelStyle: LabelStyle {
        func makeBody(configuration: Configuration) -> some View {
            HStack(alignment: .center,spacing: 10) {
                configuration.icon
                configuration.title
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    do {
        // Preview時に@Modelな値を渡す際はオンメモリであるconfigを生成してコンテナを生成しないとクラッシュする
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Game.self, configurations: config)
        let item = Game.sample
        return GameListCell(game: item)
            .modelContainer(container)
            .padding()
    } catch {
        return Text("error")
    }
}
