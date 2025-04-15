//
//  Home.swift
//  clockSync
//
//  Created by Arya Hanif on 15/04/25.
//

import SwiftUI

struct Home: View {
    @State private var showingSettingsSheet = false
    @State private var showingAddAlarmSheet = false
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea() // Background

            VStack {
                Spacer() // Pushes buttons to the bottom
                Text("21:55 - 04:45")
                    .font(.system(size: 32, weight: .bold, design: .default))
                ClockSlider()
                AlarmCard()
                HStack {
                    // Settings button
                    Button(action: {
                        showingSettingsSheet = true
                    }) {
                        Image(systemName: "gearshape.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.gray.opacity(0.3))
                            .clipShape(Circle())
                    }
                    .sheet(isPresented: $showingSettingsSheet) {
                        SettingsView()
                            .preferredColorScheme(.dark)
                    }
                    Spacer()

                    // Plus button
                    Button(action: {
                        showingAddAlarmSheet = true
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.gray.opacity(0.3))
                            .clipShape(Circle())
                    }
                    .sheet(isPresented: $showingAddAlarmSheet) {
                        AddAlarmView()
                            .preferredColorScheme(.dark)
                    }
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 30)
                Spacer() // Pushes buttons to the bottom
            }
        }
    }
}

#Preview {
    Home()
        .preferredColorScheme(.dark)
        .background(Color.black)
}
