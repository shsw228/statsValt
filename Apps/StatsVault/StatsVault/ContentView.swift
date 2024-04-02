//
//  ContentView.swift
//  StatsVault
//
//  Created by shsw228 on 2024/04/02
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var games: [Game]
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(games){ game in
                    GameListCell(game: game)
                        .padding(2)
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


