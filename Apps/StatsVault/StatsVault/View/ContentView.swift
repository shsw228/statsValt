//
//  ContentView.swift
//  StatsVault
//
//  Created by shsw228 on 2024/04/02
//

import SwiftUI
import SwiftData
import SymbolPicker

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var games: [Game]
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(games){ game in
                    NavigationLink(value: game.self) {
                        GameListCell(game: game)
                            .padding(2)
                        
                    }
                }
                .onDelete(perform: { indexSet in
                    delete(indexSet: indexSet)
                })
            }
            .overlay(content: {
                if games.isEmpty {
                    ContentUnavailableView(
                        "No Games",
                        systemImage: "gamecontroller",
                        description: Text(
                            "Add games you like!"
                        )
                    )
                }
            })
            .navigationDestination(for: Game.self){ game in
                SongListView(game: game)
            }
            .navigationTitle("Games")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Add") {
                        modelContext.insert(Game.sample)
                    }
                }
            }
        }
    }
    private func delete(indexSet: IndexSet) {
        indexSet.forEach { index in
            modelContext.delete(games[index])
        }
    }
}

#Preview {
    ContentView()
}
