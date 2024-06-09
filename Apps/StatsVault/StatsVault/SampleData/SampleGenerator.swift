//
//  SampleGenerator.swift
//  StatsVault
//  
//  Created by shsw228 on 2024/05/26
//

import Foundation
struct SampleGenerator {
    static let sampleJson: String = String(data: sample1, encoding: .utf8) ?? ""
    static let sampleJson2: String = String(data: sample2, encoding: .utf8) ?? ""
    
    static let sample1: Data = {
        guard let url = Bundle.main.url(forResource: "sampleSong", withExtension: "json") else {fatalError() }
        guard let data = try? Data(contentsOf: url) else {fatalError()}
        return data
    }()
    static let sample2: Data = {
        guard let url = Bundle.main.url(forResource: "sampleSong2", withExtension: "json") else {fatalError() }
        
        guard let data = try? Data(contentsOf: url) else {fatalError()}
        return data
    }()
    
}
