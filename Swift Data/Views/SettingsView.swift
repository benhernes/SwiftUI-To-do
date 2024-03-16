//
//  SettingsView.swift
//  Swift Data
//
//  Created by Ben Hernes on 3/16/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("About") {
                    Link("About the developer", destination: URL(string:"https://www.buymeacoffee.com/benhernes")!)
                    Link("Buy me a coffee", destination: URL(string:"https://www.buymeacoffee.com/benhernes")!)
                }
                
                Section {
                    Link("Privacy policy", destination: URL(string:"https://benhernes.notion.site/Privacy-policy-851b02c239424aae8af3dc1ba23b7463?pvs=4")!)
                } header: {
                    Text("Licenses and policies")
                } footer: {
                    Text("Thanks for using DailyTasks!")
                }
            }
            .navigationTitle("About")
        }
    }
}
