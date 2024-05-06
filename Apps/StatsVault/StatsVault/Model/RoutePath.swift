//
//  RoutePath.swift
//  StatsVault
//  
//  Created by shsw228 on 2024/05/05
//

import Foundation
import SwiftUI

enum RoutePath: Int {
    case root, setting
    
    var navigationTitle: String {
        switch self {
        case .root:
            "Games"
        case .setting:
            "Settings"
        }
        
    }
    @ViewBuilder
    func Destination() -> some View {
        switch self {
        case .root:
            ContentView()
        case .setting:
            SettingView()
        }
    }
}
