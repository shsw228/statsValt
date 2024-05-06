//
//  Defaults.swift
//  StatsVault
//  
//  Created by shsw228 on 2024/05/06
//

import Foundation
import SwiftUI
    
final class Defaults: ObservableObject {
    @AppStorage("AppAppearance") public var appearance: AppearanceMode = .system
   
}


enum AppearanceMode: String {
    case system, light, dark
    var colorScheme: ColorScheme? {
            switch self {
            case .system:
                return nil
            case .light:
                return .light
            case .dark:
                return .dark
            }
        }
}
