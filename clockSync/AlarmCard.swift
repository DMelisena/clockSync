//
//  AlarmCard.swift
//  clockSync
//
//  Created by Arya Hanif on 15/04/25.
//

import SwiftUI

struct DayOfWeekView: View {
    let days = ["S", "M", "T", "W", "T", "F", "S"]
    @State private var dayEnabled = [false, true, true, false, true, false, true] // Example boolean array
    
    var body: some View {
        HStack {
            ForEach(0..<days.count, id: \.self) { index in
                Text(days[index])
                    .foregroundColor(dayEnabled[index] ? .primary : .gray) // Set color based on boolean
                    .font(.system(size: 10))
            }
        }
    }
}

struct AlarmCard: View {
    @State private var isOn = true
    @State private var alarmTime = Date()
    var body: some View {
        HStack {
            Text("\(alarmTime, style: .time)") // Display time in HH:mm format
                .font(.title)
            //                        .padding(.leading)
            
            Spacer()
            DayOfWeekView()
            Spacer()
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle(tint: .blue))
            //                        .padding(.trailing)
        }
        .padding(.all, 2)
        //                .contentShape(Rectangle())
        //                .onLongPressGesture {
        //                    // Handle the long press to configure
        //                    showConfiguration.toggle()
        //                }
        //                .swipeActions {
        //                    // Swipe Right to show delete action
        //                    Button(action: {
        //                        // Handle delete action here
        //                        print("Alarm deleted")
        //                    }) {
        //                        Label("Delete", systemImage: "trash")
        //                            .foregroundColor(.red)
        //                    }
        //                    .tint(.red)
        //
        //                    // Swipe Left to show configuration action
        //                    Button(action: {
        //                        // Handle configuration action here
        //                        showConfiguration.toggle()
        //                    }) {
        //                        Label("Configure", systemImage: "gear")
        //                            .foregroundColor(.blue)
        //                    }
        //                    .tint(.blue)
        //                }
        //                .sheet(isPresented: $showConfiguration) {
        //                    // Configuration view when the configuration action is triggered
        //                    ConfigurationView(alarmTime: $alarmTime, isOn: $isOn)
        //                }
        
    }
}

struct AlarmCards: View {
    @State private var isOn = true
    @State private var showConfiguration = false
    @State private var alarmTime = Date()
    
    var body: some View {
        VStack{
            List {
                AlarmCard()
                AlarmCard()
                AlarmCard()
                AlarmCard()
                AlarmCard()
                AlarmCard()
                AlarmCard()
            }
            .padding(.top,-35)
            .listStyle(.grouped)
            .frame(minWidth: 0, maxWidth: .infinity)
        }
    }
}

struct ConfigurationView: View {
    @Binding var alarmTime: Date
    @Binding var isOn: Bool
    
    var body: some View {
        NavigationView {
            Form {
                DatePicker("Alarm Time", selection: $alarmTime, displayedComponents: .hourAndMinute)
                Toggle("Turn On", isOn: $isOn)
            }
            .navigationTitle("Configure Alarm")
            .navigationBarItems(trailing: Button("Done") {
                // Close configuration
            })
        }
    }
}

struct AlarmCardView: View {
    var body: some View {
        VStack {
            AlarmCards()
                .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmCardView()
            .preferredColorScheme(.dark)
    }
}
