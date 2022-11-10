//
//  DrinkWaterModel.swift
//  Flowdrate
//
//  Created by Spencer Rafada on 10/26/22.
//

import Foundation
import UserNotifications

class DrinkWaterModel: ObservableObject {
    @Published var isZero: Bool = true
    @Published var isLimit: Bool = false
    @Published var numberBottles: String = "0"
    @Published var number: Int = 0
    @Published var message: String = ""
    @Published var notificationFrequency: Double = 20
    @Published var initialGoal: Int = 0
    @Published var isGoalDone: Bool = false
    @Published var isDrinkWater: Bool = false
    
    func cancelGoal() {
        // Clear notifications
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["time"])
    }
    
    func setGoal() {
        self.initialGoal = self.number
        
        self.setNotification()
    }
    
    func setNotification() {
        /* Request Notification */
        let content = UNMutableNotificationContent()
        content.title = "Have you drinked water already?"
        content.subtitle = "Stay hydrated and be productive"
        content.body = "You have \(self.initialGoal) bottles remaining"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: (self.notificationFrequency*60), repeats: false)
        
        let request = UNNotificationRequest(identifier: "water", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func drinkWater() {
        self.isDrinkWater = true
        if self.initialGoal <= 1 {
            self.isGoalDone = true
            self.initialGoal -= 1
            self.cancelGoal()
        } else {
            self.initialGoal -= 1
        }
        if self.initialGoal == -1 {
            self.initialGoal = 0
        }
    }
    
    func increaseBottle() {
        if self.number == 15 {
            self.isLimit = true
        } else {
            self.number += 1
            self.numberBottles = String(self.number)
            self.isZero = false
            updateMessage(number: self.number)
        }
    }
    
    func decreaseBottle() {
        if self.number == 0 {
            self.isZero = true
        } else {
            self.number -= 1
            self.numberBottles = String(self.number)
            self.isLimit = false
            updateMessage(number: self.number)
        }
    }
    
    func updateMessage(number: Int) {
        switch number {
        case 1...4:
            self.message = "Drink a little bit more water. You got this!"
        case 5...7:
            self.message = "Not quite there yet..."
        case 8...12:
            self.message = "More than the average intake, nice."
        case 13...15:
            self.message = "Good job! Be proud of your self!"
        default:
            self.message = "Have you drinked water today?"
        }
    }
}

