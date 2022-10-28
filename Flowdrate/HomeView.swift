//
//  ContentView.swift
//  Flowdrate
//
//  Created by Spencer Rafada on 10/24/22.
//

import SwiftUI
import UserNotifications

class NotificationManager {
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("ERROR: \(error)")
            } else {
                print("SUCCESS")
            }
        }
    }
    #warning("Refactor this next sprint.")
}

struct HomeView: View {
    var body: some View {
        VStack{
            Image(systemName: "leaf.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.teal)
            Spacer()
            Text("Maximize your Productivity")
                .font(.system(size: 20))
                .padding()
            HStack (spacing: 50) {
                NavigationLink(destination: FlowView()) {
                    Text("Flow")
                }
                NavigationLink(destination: DrinkWaterView()) {
                    Text("Drink your Water")
                }
            }
            Spacer()
            Label("Spencer Rafada", systemImage: "brain.head.profile")
                .font(.caption)
                .opacity(0.6)
        }
        .onAppear {
            NotificationManager.instance.requestAuthorization()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
        .navigationTitle("Home")
    }
}
