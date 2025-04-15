//
//  ContentView.swift
//  clockSync
//
//  Created by Arya Hanif on 11/04/25.
import SwiftUI

// App entry point with @main attribute
@main
struct SettingsApp: App {
    var body: some Scene {
        WindowGroup {
            Home()
        }
    }
}



struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .preferredColorScheme(.dark)
    }
}
