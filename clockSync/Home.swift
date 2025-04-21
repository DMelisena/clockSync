//
//  Home.swift
//  clockSync
//
//  Created by Arya Hanif on 15/04/25.
//

import SwiftUI
//HOW TO SHOWS AM PM?? should I make a button?
//TODO: figures out how to determine the am pm condition on the clock
//or honestly just dont make it available, you can't design a sleep where you miss
//the circadian rhythm
//notification and alarm system
//TODO: Make an array that would create alarm cards
//TODO: I think the card can't be slided
//TODO: long press to delete multiple
struct Home: View {
    @State private var showingSettingsSheet = false
    @State private var showingAddAlarmSheet = false
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea() // Background
            VStack {
                Spacer() // Pushes buttons to the bottom
                ClockSlider()
                    .padding(.bottom, 50)
                AlarmCards()
                    .preferredColorScheme(.dark)
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
