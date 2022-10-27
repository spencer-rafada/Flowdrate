//
//  DrinkWaterModel.swift
//  Flowdrate
//
//  Created by Spencer Rafada on 10/26/22.
//

import Foundation

extension DrinkWaterView {
    final class DrinkWaterModel: ObservableObject {
        @Published var isZero: Bool = true
        @Published var isLimit: Bool = false
        @Published var numberBottles: String = "0"
        @Published var number: Int = 0
        @Published var message: String = "Hello!"
        
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
            case 0...5:
                self.message = "Drink a little bit more water. You got this!"
            case 6...7:
                self.message = "Not quite there yet..."
            case 8...12:
                self.message = "You're drinking more than what's recommended."
            case 13...15:
                self.message = "Good job! Be proud of your self!"
            default:
                self.message = "Have you drinked water today?"
            }
        }
    }
}