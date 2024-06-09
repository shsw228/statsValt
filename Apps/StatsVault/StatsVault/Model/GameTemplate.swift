//
//  GameTemplate.swift
//  StatsVault
//  
//  Created by shsw228 on 2024/05/18
//

import Foundation


struct Templates {
    enum GameTitle {
        case Beatmania
        case ProjectSekai //  1.0,0.7,0.5,0,0 //
        case CinderellaGirls // 1.0,0.7,0.4,0.1,0 // DEBUT, REGULAR, PRO, MASTER, MASTER+
        
        func difficulty() -> [String] {
            switch self {
            case .Beatmania:
                ["BEGINNER", "NORMAL", "HYPER", "ANOTHER", "LEGGENDARIA"]
            case .ProjectSekai:
                ["EASY", "NORMAL", "HARD", "EXPERT", "MASTER"]
            case .CinderellaGirls:
                ["DEBUT", "REGULAR", "PRO", "MASTER", "MASTER+"]
            }

        }
    }
}
