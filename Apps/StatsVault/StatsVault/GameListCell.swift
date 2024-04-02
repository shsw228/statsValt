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
    let icon: Data?
    
    var body: some View {
        
        HStack(spacing: 10){
            if let icon = icon,
               let iconImage = Image(data: icon) {
                iconImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 50)
            }
            Text(name)
                .lineLimit(2)
                .font(.body)
            Spacer()
        }
    }
    
    init(game: Game) {
        self.name = game.name
        self.sub = game.subTitle
        self.icon = game.icon
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
