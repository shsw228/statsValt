//
//  GameEditor.swift
//  StatsVault
//  
//  Created by shsw228 on 2024/05/15
//

import SwiftUI
import SymbolPicker

struct GameEditor: View {
    let game: Game?
    private var editorTitle: String {
        game == nil ? "Add Game" : "Edit Game"
    }
    
    @State private var title = ""
    @State private var icon = "gear"
    @State private var userImage: UIImage?
    @State private var iconPickerPresented = false
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Game Title", text: $title)
                Button(action: {
                    iconPickerPresented = true
                }, label: {
                    Label("Game Icon", systemImage: icon)
                })
                Button(action: {
                    // Get Album
                }, label: {
                    Label("Load icon from PhotoLibrary", systemImage: "photo")
                })
                
                    
            }.sheet(isPresented: $iconPickerPresented){
                SymbolPicker(symbol: $icon)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(editorTitle)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        withAnimation {
                            save()
                            dismiss()
                        }
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func save() {
        if let game {
            // Edit the game
            game.systemIcon = icon
            game.name = title
           // TODO: 一旦失敗時に無視
            try? modelContext.save()
        } else {
           // Add new game
            let newGame = Game(name: title, icon: icon)
            modelContext.insert(newGame)
            
            
            
        }
    }
}
