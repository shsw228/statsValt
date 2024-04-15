//
//  GameEditView.swift
//  StatsVault
//  
//  Created by shsw228 on 2024/04/16
//

import Foundation
import SwiftUI
import SymbolPicker


struct GameEditView: View {
    @Bindable var game: Game
    @State var title: String = ""
    @State private var iconPickerPresented = false
    var body: some View {
        VStack(spacing: 0){
            List{
                Section {
                    HStack{
                        Image(systemName: game.icon)
                        VStack(alignment: .leading){
                            Text(game.name)
                                .lineLimit(2)
                            Text(game.subTitle.description)
                        }
                    }
                } header: {
                    Text("サンプル")
                }
                
                HStack {
                    Image(systemName: game.icon)
                    Text(game.icon)
                        .lineLimit(1)
                }
                .onTapGesture {
                    iconPickerPresented = true
                }
                .sheet(isPresented: $iconPickerPresented, content: {
                    SymbolPicker(symbol: $game.icon)
                })
                
            }
        }
    }
    
    
}
