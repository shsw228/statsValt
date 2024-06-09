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
    let gameId: String
    @State private var isSongImport: Bool = false
    

    @Query(sort: \Song.title) private var songs: [Song]
    @Query(sort: \Game.name) private var games: [Game]
    private var currentGame: Game? {games.first}
    init(gameId: String) {
        
        self.gameId = gameId
        let predicate = #Predicate<Song> { song in
            song.owner?.storedId == gameId
            }
        let gamePredicate = #Predicate<Game> { game in
            game.storedId == gameId
            }
        _songs = Query(filter: predicate, 
                       sort:[
                        SortDescriptor(\Song.title),
                        SortDescriptor(\Song.level)
                       ])
        _games = Query(filter: gamePredicate,sort:\Game.name)
    }
    var body: some View {
        List {
            ForEach(songs) { song in
                SongListCell(song: song)
                    .listRowInsets(EdgeInsets()) //  内部Padding無効
                    .contentShape(.rect) // タッチ領域を自身サイズに拡大
                // MARK: count 2 -> 1 にしないと2が呼ばれない
                    .onTapGesture(count: 2){
                        // double tap gesture
                        song.cleared = .fullCombo
                    }
                    .onTapGesture(count: 1) {
                        song.cleared = .clear
                    }
                    .listStyle(.inset)
            }
            
            .onDelete { index in
                delete(indexSet: index)
            }
        }
        .overlay {
            if songs.isEmpty {
                ContentUnavailableView{
                    Label("No Songs",systemImage: "music.note.list")
                } description:{
                    Text("Add songs you like!")
                    
                }
            }
        }
        .sheet(isPresented: $isSongImport){
            SongImporter(selectedGame: currentGame)
        }
        .navigationTitle("SongList")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Add") {
                    // Song Add feature
                    isSongImport = true
                }
            }
        }
    }
    
    private func delete(indexSet: IndexSet) {
        indexSet.forEach { index in
            modelContext.delete(songs[index])
        }
    }
}
struct SongListCell: View {
    let song: Song
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            song.cleared.rampColor.frame(width: 10, alignment: .leading)
            Label(
                title: { Text(song.title)
                    .font(Font.system(size: 12))},
                icon: { song.songLebelIcon}
            ).labelStyle(SongLabelStyle())
            
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
    ModelContainerPreview(ModelContainer.sample) {
        NavigationStack {
            SongListView(gameId: Game.japanese_short.storedId)
            
        }
    }
    
}
#Preview(traits: .sizeThatFitsLayout){
    ModelContainerPreview(ModelContainer.sample) {
        NavigationStack {
            SongListView(gameId: Game.japanese_long.storedId)
            
        }
    }
    
}
