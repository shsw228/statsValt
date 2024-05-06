//
//  Song.swift
//  StatsVault
//  
//  Created by shsw228 on 2024/04/15
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Song {
    var title: String
    var createdAt: String = Date.now.description
    var lastEditAt: String = Date.now.description
    var level: Int
    var difficultiy: Int?
    
    // Specified different level song as variation
    //    var songIdentifier: String?
    // Array stored score counts.
    // For ex.(Project Sekai)
    // [100, 20, 1, 2, 0] -> Perfect:100, Great:20, Good:1, Bad:2, Miss:0
    var detailScore: [Int] = [0]
    
    var owner: Game?
    var cleard:ClearStateType
    var grade: SongEvalutionType { .F }
    
    var detailScoreTypeCount: Int {
        return detailScore.count
    }
    
    var rate: [Double] {
        return owner?.scoreCalcurateRate ?? []
    }
    var songLebelIcon: Image { Image(systemName: "\(level).circle")  }
    
    // アプリ内部レート評価タイプ
    enum SongEvalutionType: String {
        case F,C,B,A,AA,AAA
        var image: Image {
            switch self {
            case .F:
                Image(systemName: "f.circle")
            case .C:
                Image(systemName: "c.circle")
            case .B:
                Image(systemName: "b.circle")
            case .A, .AA, .AAA:
                Image(systemName: "a.circle")
                // TODO: AA,AAAに関してはCustomSFSymbolsを作成して対応
            }
        }
    }
    
    
    init(
        title: String,
        songLebel: Int = 0,
        owner: Game,
        cleard: ClearStateType = .failed
    ) {
        self.title = title
        self.owner = owner
        self.level = songLebel
        self.cleard = cleard
    }
    
    func update<T>(keyPath: ReferenceWritableKeyPath<Song, T>, to value: T) {
        self[keyPath: keyPath] = value
        lastEditAt = Date.now.description
    }
 }
// 楽曲クリア状況
enum ClearStateType: String, Codable, CaseIterable{
    case noPlay
    case failed
    case easy
    case clear
    case fullCombo
    case allPerfect
    var rampColor: Color {
        switch self {
        case .noPlay:
            Color.clear
        case .failed:
            Color.red
        case .easy:
            Color.green
        case .clear:
            Color.blue
        case .fullCombo:
            Color.red
        case .allPerfect:
            Color.purple
        }
    }
}
