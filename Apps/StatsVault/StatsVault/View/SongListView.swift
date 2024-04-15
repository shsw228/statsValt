//
//  SongListView.swift
//  StatsVault
//  
//  Created by shsw228 on 2024/04/16
//

import Foundation
import SwiftUI

struct SongListView: View {
    let game: Game
    @Environment(\.modelContext) var modelContext
    var body: some View {
            List {
                ForEach(game.songs) { game in
                    Text(game.title)
                }.onDelete(perform: { indexSet in
                    delete(indexSet: indexSet)
                })
            }
            
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Add") {
                            let song = Song(title: "sample", owner: game)
                        game.songs.append(song)
                    }
                }
            }
        
    }
    
    private func delete(indexSet: IndexSet) {
        indexSet.forEach { index in
            modelContext.delete(game.songs[index])
        }
    }
}
