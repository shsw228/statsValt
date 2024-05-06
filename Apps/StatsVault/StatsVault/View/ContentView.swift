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
    @State var path = NavigationPath()
    
    @State var isSetting: Bool = false
    @Query var games: [Game]
    
    var body: some View {
        NavigationStack(path: $path) {
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
            .navigationDestination(for: RoutePath.self, destination: { int in
                int.Destination()
                    .navigationTitle(int.navigationTitle)
                    .navigationBarTitleDisplayMode(.inline)
                    
            })
            .navigationTitle("Games")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    
                    Button("Add") {
                        modelContext.insert(Game.sample)
                    }
                    Button(
                        action: { path.append(RoutePath.setting)},
                        label: {
                        Image(systemName: "gear")
                    })
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
