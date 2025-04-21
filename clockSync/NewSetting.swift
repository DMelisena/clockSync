//
//  NewSetting.swift
//  clockSync
//
//  Created by Arya Hanif on 17/04/25.
//

import SwiftUI

struct NewSettingsView: View {
    // State variables loaded from UserDefaults
    @State private var sleepAlarm = UserDefaults.standard.bool(forKey: "sleepAlarm")
    @State private var keyDevice = UserDefaults.standard.string(forKey: "keyDevice") ?? "Iphone"
    @State private var beforeSleepReminder = UserDefaults.standard.string(forKey: "beforeSleepReminder") ?? "1 hour"
    @State private var defaultAlarmTone = UserDefaults.standard.string(forKey: "defaultAlarmTone") ?? "For River"
    @State private var randomizedAlarm = UserDefaults.standard.bool(forKey: "randomizedAlarm")
    @State private var consecutiveMode = UserDefaults.standard.bool(forKey: "consecutiveMode")
    @State private var allowSnooze = UserDefaults.standard.bool(forKey: "allowSnooze")
    @State private var defaultTimezone = UserDefaults.standard.bool(forKey: "defaultTimezone")
    @State private var snoozeInterval = UserDefaults.standard.string(forKey: "snoozeInterval") ?? "5 mins"
    @State private var selectedTimeZone = UserDefaults.standard.string(forKey: "selectedTimeZone") ?? TimeZone.current.identifier
    @State private var selectedMinutes = UserDefaults.standard.integer(forKey: "selectedMinutes")
    
    let timeZones = TimeZone.knownTimeZoneIdentifiers
    let alarmSounds = ["Chimes", "Radar", "Beacon", "Marimba", "Circuit"]
    let keyDevices = ["Iphone", "Mac", "IWatch"]
    let beforeSleepReminders = ["5 minutes", "10 minutes", "30 minutes", "1 hour", "2 hours"]
    let defaultAlarmTones = ["For River", "music 1", "music 2", "music 3", "music 4"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Settings")) {
                    Toggle("Sleep Alarm", isOn: $sleepAlarm)
                        .onChange(of: sleepAlarm) { UserDefaults.standard.set(sleepAlarm, forKey: "sleepAlarm") }
                    Picker("Key Device", selection: $keyDevice) {
                        ForEach(keyDevices, id: \.self) { device in
                            Text(device)
                        }
                    }
                    .onChange(of: keyDevice) { UserDefaults.standard.set(keyDevice, forKey: "keyDevice") }

                    Picker("Sleep Reminder", selection: $beforeSleepReminder) {
                        ForEach(beforeSleepReminders, id: \.self) { reminder in
                            Text(reminder)
                        }
                    }
                    .onChange(of: beforeSleepReminder) { UserDefaults.standard.set(beforeSleepReminder, forKey: "beforeSleepReminder") }

                    Picker("Default Ringtone", selection: $defaultAlarmTone) {
                        ForEach(defaultAlarmTones, id: \.self) { tone in
                            Text(tone)
                        }
                    }
                    .onChange(of: defaultAlarmTone) { UserDefaults.standard.set(defaultAlarmTone, forKey: "defaultAlarmTone") }

                    Toggle("Randomize Alarm", isOn: $randomizedAlarm)
                        .onChange(of: randomizedAlarm) { UserDefaults.standard.set(randomizedAlarm, forKey: "randomizedAlarm") }

                    Toggle("Allow Snooze", isOn: $allowSnooze)
                        .onChange(of: allowSnooze) { UserDefaults.standard.set(allowSnooze, forKey: "allowSnooze") }

                    if allowSnooze {
                        Picker("Minutes", selection: $selectedMinutes) {
                            ForEach(Array(stride(from: 0, to: 60, by: 5)), id: \.self) { minute in
                                Text("\(minute) min").tag(minute)
                            }
                        }
                        .pickerStyle(.menu)
                        .onChange(of: selectedMinutes) { UserDefaults.standard.set(selectedMinutes, forKey: "selectedMinutes") }
                    }

                    Toggle("Consecutive Mode", isOn: $consecutiveMode)
                        .onChange(of: consecutiveMode) { UserDefaults.standard.set(consecutiveMode, forKey: "consecutiveMode") }

                    Toggle("Use Default Timezone", isOn: $defaultTimezone)
                        .onChange(of: defaultTimezone) { UserDefaults.standard.set(defaultTimezone, forKey: "defaultTimezone") }

                    if !defaultTimezone {
                        Picker("", selection: $selectedTimeZone) {
                            ForEach(timeZones, id: \.self) { zone in
                                Text(zone).tag(zone)
                            }
                        }
                        .pickerStyle(.menu)
                        .onChange(of: selectedTimeZone) { UserDefaults.standard.set(selectedTimeZone, forKey: "selectedTimeZone") }
                    }

                    Button("Customize Button") {
                        // Action here
                    }
                    .padding(.all, 6)
                }
                .padding(.all, 6)
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NewSettingsView()
        .preferredColorScheme(.dark)
}
