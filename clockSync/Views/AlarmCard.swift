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
    var alarm: Alarm
    @State private var isOn = true
    
    init(alarm: Alarm) {
        self.alarm = alarm
        self._isOn = State(initialValue: alarm.isOn)
    }
    @State private var alarmTime = Date()


    var body: some View {
        HStack {
            Text("\(alarm.time, style: .time)") // Display time in HH:mm format
                .font(.title)
            
            Spacer()
            DayOfWeekView()
            Spacer()
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle(tint: .blue))
        }
        .padding(.all, 2)
    }
}

struct AlarmCards: View{
    @State private var isOn = true
    @State private var showConfiguration = false
    @State private var alarmTime = Date()
    
    @Binding var alarms: [Alarm]
    var body: some View {
        VStack{
            List {ForEach(alarms.indices, id: \.self) { index in
                AlarmCard(alarm: self.alarms[index])
                }
            }
            .padding(.top,-35)
            .listStyle(.grouped)
            .frame(minWidth: 0, maxWidth: .infinity)
        }
        .onAppear {
            if let savedData = UserDefaults.standard.data(forKey: "alarms"),
               let decoded = try? JSONDecoder().decode([Alarm].self, from: savedData) {
                print("====xxxxx=====")
                print(alarm)
//                alarms = decoded
                print("=====xxxxx===")

            }
        }

        .preferredColorScheme(.dark)
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

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlarmCards()
//    }
//}
//
