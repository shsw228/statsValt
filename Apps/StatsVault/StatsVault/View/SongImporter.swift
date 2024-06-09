//
//  SongImporter.swift
//  StatsVault
//  
//  Created by shsw228 on 2024/05/15
//

import SwiftUI
import SwiftData
import HighlightSwift


struct SongImporter: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    private var selectedGame: Game?
    
    @State private var importUrl: String = ""
    @State private var isImporting: Bool = false
    @State private var isSamplePreviewed: [Bool] = [false,false]
    @State private var importedJson = ""
    @State private var currentSong: String = ""
    let text: String = SampleGenerator.sampleJson
    let text2: String = SampleGenerator.sampleJson2
    
    init(selectedGame:Game?) {
        self.selectedGame = selectedGame
    }
    var body: some View {
        NavigationStack {
            Form {
                Section("From Url") {
                    TextField("Download from", text: $importUrl)
                        .keyboardType(.URL)
                        .textContentType(.URL)
                    Button("Fetch song file(Under In construction)") {
                        // Fetch Song config
                    }.disabled(true)
                    
                }
                            
                Section("From local") {
                    Button("Open Files(Under In construction)") {
                        // Fetch Song config
                        isImporting = true
                    }
                    if !importedJson.isEmpty {
                        CodeText(importedJson)
                            .codeTextLanguage(.json)
                            .font(Font.system(size: 12))
                    }
                }
                Section("From Sample") {
                    Button("Defined as list") {
                        isSamplePreviewed[SampleType.List.rawValue].toggle()
                    }
                    if isSamplePreviewed[SampleType.List.rawValue] {
                        Button {
                            // Under in construction
                            let sampleData = SampleGenerator.sample1
                            do {
                                let songs = try JSONDecoder().decode([Song].self, from: sampleData)
                                insertSongs(context: modelContext, songs: songs, indicator: $currentSong)
                                
                            } catch {
                                print("failed to load songs")
                            }
                        } label: {
                            Label {
                                Text("Add sample songs")
                            } icon: {
                                Image(systemName: "square.and.arrow.down.on.square")
                            }

                        }
                        

                        CodeText(text)
                            .codeTextLanguage(.json)
                            .font(Font.system(size: 12))
                    }
                    
                    Button("Defined same songs as same array") {
                        isSamplePreviewed[SampleType.Array.rawValue].toggle()
                        print(text)
                    }
                    if isSamplePreviewed[SampleType.Array.rawValue] {
                        Button {
                            // Under in construction
                        } label: {
                            Label {
                                Text("Add sample songs")
                            } icon: {
                                Image(systemName: "square.and.arrow.down.on.square")
                            }

                        }
                        .disabled(true)

                        CodeText(text2)
                            .codeTextLanguage(.json)
                            .font(Font.system(size: 12))
                    }
                }
            }
            
            .fileImporter(isPresented: $isImporting, allowedContentTypes: [.json]) {result in
                switch result {
                case .success(let success):
                    do {
                        importedJson = try read(from: success).get()
                    } catch {
                        
                    }
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Song Importer")
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
            .onChange(of: currentSong) {
                print(currentSong)
            }
            .onChange(of: selectedGame) { oldValue, newValue in
                print(oldValue,newValue)
            }
        }
    }
    private func read(from url: URL) -> Result<String,Error> {
      let accessing = url.startAccessingSecurityScopedResource()
      defer {
        if accessing {
          url.stopAccessingSecurityScopedResource()
        }
      }

      return Result { try String(contentsOf: url) }
    }
    
    private func insertSongs(context:ModelContext, songs: [Song], indicator: Binding<String>? ) {
        context.autosaveEnabled = false
        defer {
            context.autosaveEnabled = true
            indicator?.wrappedValue = "finished."
        }
        let count = songs.count
        print(count)
        songs
            .enumerated()
            .forEach { index, item in
                item.owner = selectedGame
                context.insert(item)
                print(item, index)
                indicator?.wrappedValue = "\(index) of \(count)"
            }
    
        do {
            try context.save()
        } catch  {
            print(error.localizedDescription)
        }
    }
}
extension SongImporter {
    enum SampleType: Int {
        case List
        case Array
    }
}
#Preview {
    ModelContainerPreview(ModelContainer.sample) {
        SongImporter(selectedGame: Game.japanese_short)
    }
}
