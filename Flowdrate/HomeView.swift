//
//  ContentView.swift
//  Flowdrate
//
//  Created by Spencer Rafada on 10/24/22.
//

import SwiftUI

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
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) {
                success, error in
                if success {
                    print("Requested Permission for Notifications.")
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
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
