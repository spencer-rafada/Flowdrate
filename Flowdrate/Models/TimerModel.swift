//
//  TimerModel.swift
//  Flowdrate
//
//  Created by Spencer Rafada on 10/24/22.
//

import Foundation
import UserNotifications


final class FlowModel: ObservableObject {
    @Published var isActive = false
    @Published var showingAlert = false
    @Published var time: String = "5:00"
    @Published var minutes: Float = 5.0 {
        didSet {
            self.time = "\(Int(minutes)):00"
        }
    }
    
    private var initialTime = 0
    private var endDate = Date()
    
    func start(minutes: Float) {
        self.initialTime = Int(minutes)
        self.endDate = Date()
        self.isActive = true
        self.endDate = Calendar.current.date(byAdding: .minute, value: Int(minutes), to: endDate)!
        
        
        /* Request Notification */
        let calendar = Calendar.current
        var date = DateComponents()
        date.hour = calendar.component(.hour, from: endDate)
        date.minute = calendar.component(.minute, from: endDate)
        date.second = calendar.component(.second, from: endDate)
        //print(date)
        
        let content = UNMutableNotificationContent()
        content.title = "Flow Timer is up! Good job!"
        content.subtitle = "Take a quick break and go again."
        content.body = "It is effective to make a list of tasks before starting your next focus time."
        content.sound = UNNotificationSound.default
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        
        let request = UNNotificationRequest(identifier: "time", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    /* func pauseResume() {
     self.isActive = false
     
     } */
    
    func reset() {
        self.minutes = Float(initialTime)
        self.isActive = false
        self.time =  "\(Int(minutes)):00"
        
        /* Clear Notifications */
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["time"])
    }
    
    func updateCountdown() {
        guard isActive else { return }
        
        let now = Date()
        let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
        
        if diff <= 0 {
            self.isActive = false
            self.time = "0:00"
            self.showingAlert = true
            return
        }
        
        let date = Date(timeIntervalSince1970: diff)
        let calendar = Calendar.current
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        print(time)
        
        self.minutes = Float(minutes)
        self.time = String(format: "%d:%02d", minutes, seconds)
    }
}

