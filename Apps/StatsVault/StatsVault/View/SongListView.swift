//
//  SongListView.swift
//  StatsVault
//
//  Created by shsw228 on 2024/04/16
//

import Foundation
import SwiftUI
import SwiftData

struct SongListView: View {
    @Environment(\.modelContext) var modelContext
    let game: Game
    
    var sortedSongs: [Song] {
        return game.songs.sorted(using: SortDescriptor(\.songLevel))
    }
    
    
    var body: some View {
        List(sortedSongs) { song in
            SongListCell(song: song)
        }
        .navigationTitle("SongList")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Add") {
                    let next = Int.random(in: 0 ..< 100)
                    let song = Song(title: "sample\(next)",songLebel: next, owner: game)
                    withAnimation {
                        game.songs.append(song)
                    }

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
struct SongListCell: View {
    let song: Song
    
    var body: some View {
        HStack {
            Label(
                title: { Text(song.title) },
                icon: { song.songLebelIcon}
            )
            Image(systemName: ")
        }
        
        
        
    }
}

#Preview(traits: .sizeThatFitsLayout){
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Song.self, configurations: config)
    let game = Game(name: "sampleGame", subTitle: Date.now)
    let song = Song(title: "Sample", owner: game)
    return List {
        SongListCell(song: song)
            .modelContainer(container)
            .frame(width: 300, height: 50)
            .padding()
            .border(.black)
    }
    
    
}
