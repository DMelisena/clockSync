//
//  NotifUI.swift
//  clockSync
//
//  Created by Arya Hanif on 06/05/25.
//

import CoreLocation
import SwiftUI
import UserNotifications

class NotificationManager {
    static let instance = NotificationManager()

    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { _, error in
            if let error = error {
                print("ERROR: \(error)")
            } else {
                print("SUCCESS")
            }
        }
    }

    func scheduledNotification() {
        let content = UNMutableNotificationContent()
        content.title = "This is my first notification"
        content.subtitle = "This is easy"
        content.sound = .default
        content.badge = 1

        // uncomment to use specific Trigger
        // Time trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
//
//        Calendar Trigger
//        var dateComponents = DateComponents()
//        dateComponents.hour = 3
//        dateComponents.minute = 13
//        dateComponents.weekday = 3
//        let trigger = UNCalendarNotificationTrigger(
//            dateMatching: dateComponents,
//            repeats: true)
//
//        Location Trigger
//        let coordinates = CLLocationCoordinate2D(latitude: 32.6514, longitude: -161.4333)
//        let region = CLCircularRegion(
//            center: coordinates, radius: 100,
//            identifier: UUID().uuidString)
//
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }

    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }

    func resetBadgeCount() {
        UNUserNotificationCenter.current().setBadgeCount(0) { error in
            if let error = error {
                print("Error resetting badge count: \(error)")
            } else {
                print("Badge count reset to 0")
            }
        }
    }
}

struct LocalNotificationBoot: View {
    @State private var badgeCount: Int = 0
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        VStack(spacing: 40) {
            Button("Request Permission") {
                NotificationManager.instance.requestAuthorization()
            }
            Button("Schedule Notification") {
                NotificationManager.instance.scheduledNotification()
            }
            Button("Reset Badge") {
                NotificationManager.instance.resetBadgeCount()
                badgeCount = 0 // Update the local state as well
            }
            Text("Current Badge Count: \(badgeCount)")
            Button("Cancel Notification") {
                NotificationManager.instance.cancelNotification()
            }
        }
        // onappear won't get called for momentarily close and reopen the app, comment .onchange to disable
        .onChange(of: scenePhase) { _, newValue in
            if newValue == .active {
                NotificationManager.instance.resetBadgeCount()
            }
        }
    }
}

struct LocalNotificationBoot_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationBoot()
    }
}
