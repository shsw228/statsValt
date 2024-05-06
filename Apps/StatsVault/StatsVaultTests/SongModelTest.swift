//
//  SongModelTest.swift
//  StatsVaultTests
//  
//  Created by shsw228 on 2024/04/23
//

import XCTest
import SwiftData


@testable import StatsVault
final class SongModelTest: XCTestCase {
    
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    var container: ModelContainer?
    var game: Game?
    var song: Song?
    
    override func setUpWithError() throws {
        container = try! ModelContainer(for: Song.self, configurations: config)
        game = Game(name: "sampleGame", subTitle: Date.now)
        song = Song(title: "Sample", owner: game!)
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testComputed()  {
        let count  = game?.scoreCalcurateRate
        let songCount = song?.rate
        XCTAssertEqual(count, songCount)
    }
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
