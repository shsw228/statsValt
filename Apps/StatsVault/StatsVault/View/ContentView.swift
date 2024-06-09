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
    @State private var isEditorPresented = false
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
            .overlay {
                if games.isEmpty {
                    ContentUnavailableView{
                        Label("No Games",systemImage: "gamecontroller")
                    } description:{
                        Text("Add games you like!")
                        
                    }
                }
            }
            .navigationDestination(for: Game.self){ game in
                SongListView(gameId: game.storedId)
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
                        // Game追加画面を表示
                        isEditorPresented = true
                    }
                    Button(
                        action: { path.append(RoutePath.setting)},
                        label: {
                        Image(systemName: "gear")
                    })
                }
            }
            .sheet(isPresented: $isEditorPresented) {
                GameEditor(game: nil)            }
        }
    }
    private func delete(indexSet: IndexSet) {
        indexSet.forEach { index in
            modelContext.delete(games[index])
        }
    }
}
#Preview {
    ModelContainerPreview(ModelContainer.sample) {
        NavigationStack {
            ContentView()
        }
    }
}
