//
//  UserDefaults.swift
//  clockSync
//
//  Created by Arya Hanif on 17/04/25.
//

import SwiftUI

struct TapView: View {
    @State private var tapCount = UserDefaults.standard.integer(forKey: "tapCount")
    var body: some View {
        Button("Tap Count: \(tapCount)"){
            tapCount += 1
            
            UserDefaults.standard.set(tapCount, forKey: "tapCount")
        }
    }
}

#Preview {
    TapView()
}
