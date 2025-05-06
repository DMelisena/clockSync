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

        // uncomment to use Time trigger
        // Time trigger
         let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)

//        // Calendar Trigger
//        var dateComponents = DateComponents()
//        dateComponents.hour = 3
//        dateComponents.minute = 13
//        dateComponents.weekday = 3
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents,
//                                                 repeats: true)

        // location
//        let coordinates = CLLocationCoordinate2D(latitude: 32.6514, longitude: -161.4333)
//        let region = CLCircularRegion(center: coordinates, radius: 100, identifier: UUID().uuidString)
        
        

        
        
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
        // This is not implemented on new swift version
//        .onAppear {
//            UNUserNotificationCenter.current().getBadgeCount { count in
//                badgeCount = count
//            }
//        }
                .onAppear {
            // This block should not be reached if deployment target is >= iOS 15.0
//            badgeCount = UIApplication.shared.applicationIconBadgeNumber
            // NotifUI.swift:102:47 'applicationIconBadgeNumber' was deprecated in iOS 17.0: Use -[UNUserNotificationCenter setBadgeCount:withCompletionHandler:] instead.
            NotificationManager.instance.resetBadgeCount()
            UNUserNotificationCenter.current().setBadgeCount(0) { error in
                if let error = error {
                    print("Error resetting badge count: \(error)")
                } else {
                    print("Badge count reset to 0")
                }
            }

            print("Warning: Using deprecated applicationIconBadgeNumber for initial badge count.")
            // this seems to be a better implementation
            // https://developer.apple.com/documentation/usernotifications/unusernotificationcenter/setbadgecount(_:withcompletionhandler:)
            // but UNUserNotificationCenter.current().setBadgeCount(0) didn't work when I tried it.
        }
        //TODO: Make the red badge gone if I open the app
//        .onAppear {
//            // This block should not be reached if deployment target is >= iOS 15.0
////            badgeCount = UIApplication.shared.applicationIconBadgeNumber
//            // NotifUI.swift:102:47 'applicationIconBadgeNumber' was deprecated in iOS 17.0: Use -[UNUserNotificationCenter setBadgeCount:withCompletionHandler:] instead.
//            
//            NotificationManager.instance.resetBadgeCount()
//            UNUserNotificationCenter.current().setBadgeCount(0) { error in
//                if let error = error {
//                    print("Error resetting badge count: \(error)")
//                } else {
//                    print("Badge count reset to 0")
//                }
//            }
//
//            print("Warning: Using deprecated applicationIconBadgeNumber for initial badge count.")
//            // this seems to be a better implementation
//            // https://developer.apple.com/documentation/usernotifications/unusernotificationcenter/setbadgecount(_:withcompletionhandler:)
//            // but UNUserNotificationCenter.current().setBadgeCount(0) didn't work when I tried it.
//        }
    }
}

struct LocalNotificationBoot_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationBoot()
    }
}
