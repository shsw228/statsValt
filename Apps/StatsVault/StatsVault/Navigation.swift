//
//  Navigation.swift
//  StatsVault
//  
//  Created by shsw228 on 2024/04/07
//

import Foundation

class Navigations: ObservableObject {
    enum Item: Hashable {
        case game(Game)
        case song
    }
       @Published var path = [Item]()
   }
