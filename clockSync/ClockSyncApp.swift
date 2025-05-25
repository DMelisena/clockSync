//
//  ClockSyncApp.swift
//  clockSync
//
//  Created by Arya Hanif on 25/05/25.
//

import SwiftUI
//import XcodebuildNvimPreview

@main
struct ClockSyncApp: App {
    var body: some Scene {
        WindowGroup {
            Home()
//        LocalNotificationBoot()
//                .setupNvimPreview { HomeView() }
        }
    }
}

#Preview {
    Home()
}
