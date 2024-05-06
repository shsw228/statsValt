//
//  SettingView.swift
//  StatsVault
//
//  Created by shsw228 on 2024/05/04
//

import Foundation
import SwiftUI

struct SettingView: View {
    @Environment(\.openURL) var openURL
    // TODO: ViewModel
    private let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    private let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    private let pasteboard = UIPasteboard.general
    
    @State var copied: Bool = false // To fire sensoryFeedback
    @StateObject var defaults = Defaults()
    
    var body: some View {
        List {
            Section {
                HStack {
                    Spacer()
                    Image("header", bundle: nil)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 400, alignment: .center)
                }
                Text("App Description")
                
            }
            Section {
                Picker(selection: defaults.$appearance) {
                    ForEach(AppearanceMode.allCases, id: \.self) { value in
                        Text(value.rawValue).tag(value)
                    }
                    
                } label: {
                    Text("Appearance")
                }

                
            } header: {
                Text("General")
            }
            Section {
                Button(action: {
                    openURL(URL(string: "https://twitter.com/shsw228")!)
                }, label: {
                    Label(
                        title: { Text("shsw228")},
                        icon: { Image("x-twitter") }
                    )
                    .labelStyle(SettingLabelStyle())
                    
                })
                
                Button(
                    action: {
                        openURL(URL(string: "https://github.com/shsw228")!)
                    },
                    label: {
                        
                        Label(
                            title: { Text("shsw228")},
                            icon: { Image("github")
                                .symbolVariant(.fill)}
                        ).labelStyle(SettingLabelStyle())
                        
                    })
                
                
            } header: {
                Text("Author")
            }
            
            Section {
                LabeledContent {
                    Text(version)
                } label: {
                    Text("Version")
                }
                .onLongPressGesture {
                    pasteboard.string = version
                    copied.toggle()
                }
                .sensoryFeedback(.increase, trigger: copied)
                
                LabeledContent {
                    Text(build)
                } label: {
                    Text("Build")
                }
                .onLongPressGesture {
                    pasteboard.string = build
                    copied.toggle()
                }
                .sensoryFeedback(.success, trigger: copied)
                
            } header: {
                Text("About App")
            }
            Button(action: {
                pasteboard.string = "Version:" + version + "/" + "Build:" + build
                copied.toggle()
            }, label: {
                Label(
                    title: { Text("Version and Build") },
                    icon: { Image(systemName: "doc.on.clipboard") }
                )
                
            })
            .sensoryFeedback(.success, trigger: pasteboard)
        }
    }
}
struct SettingLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center, spacing: 20) {
            configuration.icon
            configuration.title
                .monospaced()
        }
        
    }
}

#Preview {
    SettingView()
}
