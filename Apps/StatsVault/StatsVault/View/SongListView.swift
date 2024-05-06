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
        return game.songs.sorted(using: SortDescriptor(\.title))
    }
    
    
    var body: some View {
        List {
            ForEach(sortedSongs) { song in
                SongListCell(song: song)
                    .listRowInsets(EdgeInsets()) //  内部Padding無効
                // MARK: count 2 -> 1 にしないと2が呼ばれない
                    .onTapGesture(count: 2){
                        // double tap gesture
                        song.cleard = .fullCombo
                    }
                    .onTapGesture(count: 1) {
                        song.cleard = .clear
                    }
                    .listStyle(.inset)
            }
        }
        .navigationTitle("SongList")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Add") {
                    let next = Int.random(in: 0 ..< 50)
                    let song = Song(title: "サンプルサンプル\(next)",songLebel: next, owner: game)
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
        HStack(alignment: .center, spacing: 0) {
            song.cleard.rampColor.frame(width: 10, alignment: .leading)
            Label(
                title: { Text(song.title)
                    .font(Font.system(size: 12))},
                icon: { song.songLebelIcon}
            )
            
            Spacer()
            song.grade.image
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
        }
    }
}

struct SongLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center,spacing: 10) {
            configuration.icon
            configuration.title
        }
    }
}
#Preview(traits: .sizeThatFitsLayout){
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Song.self, configurations: config)
    let game = Game(name: "sampleGame", subTitle: Date.now)
    let song = Song(title: "Sample", songLebel: 1, owner: game, cleard: .clear)
    return SongListCell(song: song)
        .modelContainer(container)
        .frame(width: 300, height: 50)
        .border(.black)
    
    
    
}
