//
//  DrinkWaterView.swift
//  Flowdrate
//
//  Created by Spencer Rafada on 10/25/22.
//

import SwiftUI

struct DrinkWaterView: View {
    @StateObject private var wm = DrinkWaterModel()
    private let width: Double = 250
    var body: some View {
        VStack (spacing: 10) {
            HStack {
                Image(systemName: "drop.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.teal)
                    .frame(width: 30, height: 30)
                Text("Drink your Water!")
                    .foregroundColor(.teal)
                    .font(.system(size: 30))
            }
            // Allows user to determine how much water user wants to drink
            VStack {
                Text("How many water do you want to drink?")
                    .tint(.teal)
                    .font(.caption)
                HStack (spacing: 50) {
                    Button(action: {wm.decreaseBottle()}) {
                        Image(systemName: "minus")
                    }
                    .disabled(wm.isZero)
                    Text("\(wm.numberBottles)")
                        .font(.system(size: 80))
                    Button(action: {wm.increaseBottle()}) {
                        Image(systemName: "plus")
                    }
                    .disabled(wm.isLimit)
                }
            }
            // Display how much water user wants to drink
            VStack (spacing: 5) {
                Text("\(wm.message)")
                    .opacity(0.7)
                HStack {
                    ForEach(0..<wm.number, id: \.self) {_ in
                        Image(systemName: "drop.fill")
                            .foregroundColor(.teal)
                    }
                }
                .fixedSize(horizontal: true, vertical: false)
                .frame(maxWidth: 250)
            }
            Divider()
            // Configure notification
            VStack (spacing: 10) {
                Text("How often do you want to get notified?")
                Text("Every \(Int(wm.notificationFrequency)) minutes")
                    .opacity(0.7)
                Slider(value: $wm.notificationFrequency, in: 1...60, step: 1)
                    .padding()
                    .frame(width: width)
                    .animation(.easeInOut, value: wm.notificationFrequency)
                    .tint(.teal)
                Button(action: {wm.setGoal()}) {
                    HStack(spacing: 15){
                        Image(systemName: "star.fill")
                        Text("Set Reminder")
                            .italic()
                    }
                    .padding()
                }
                .background(.teal)
                .tint(.white)
                .cornerRadius(25)
                
                Button(action: {wm.cancelGoal()}){
                    Text("Cancel reminder")
                        .italic()
                        .underline()
                        .font(.caption)
                        .foregroundColor(.gray)
                        .opacity(0.7)
                }
            }
            Divider()
            // Display how much bottles left after drinking.
            VStack (spacing: 20){
                Text("You have \(wm.initialGoal) bottles remaining")
                    .alert(isPresented: $wm.isDrinkWater) {
                        Alert(title: Text("Good job drinking your water!"),
                              message: Text("We suggest to set a new goal if you drinked all of your water to continually be reminded."),
                              primaryButton: .default(Text("Continue to remind me")) {
                            wm.setNotification()
                        },
                              secondaryButton: .cancel(Text("Cancel")){
                            wm.cancelGoal()
                        })
                    }
                Button(action: {wm.drinkWater()}) {
                    Text("I drinked water!")
                }
                
            }
        }
    }
}

struct DrinkWaterView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkWaterView()
    }
}
