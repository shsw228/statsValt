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
class Song: Codable{
    @Attribute(.unique)
    var storedId: String = UUID().uuidString
    var createdAt: String = Date.now.description
    var lastEditAt: String = Date.now.description
    
    var songIdentifierId: String?
    var title: String
    var level: Int
    var difficulty: Int?
    
    // Array stored score counts.
    // For ex.(Project Sekai)
    // [100, 20, 1, 2, 0] -> Perfect:100, Great:20, Good:1, Bad:2, Miss:0
    var detailScore: [Int] = [0]
    
    var owner: Game?
    var cleared: ClearStateType
    var grade: SongEvaluateType { .F }
    
    var detailScoreTypeCount: Int {
        return detailScore.count
    }
    
    var rate: [Double] {
        return owner?.scoreCalcurateRate ?? []
    }
    var songLebelIcon: Image { Image(systemName: "\(level).circle")  }
    
    // MARK: Codable
    enum CodingKeys: CodingKey {
        case title, level, difficulty, cleared
    }
    
    // アプリ内部レート評価タイプ
    enum SongEvaluateType: String {
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
        cleared: ClearStateType = .failed
    ) {
        self.title = title
        self.level = songLebel
        self.cleared = cleared
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        level = try container.decodeIfPresent(Int.self, forKey: .level) ?? 0
        let clearState = try container.decodeIfPresent(Int.self, forKey: .cleared) ?? 0
        cleared = ClearStateType(rawValue: clearState) ?? .noPlay
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
    }
    
}
// 楽曲クリア状況
enum ClearStateType: Int, Codable, CaseIterable{
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
