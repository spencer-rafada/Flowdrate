//
//  FlowView.swift
//  Flowdrate
//
//  Created by Spencer Rafada on 10/24/22.
//

import SwiftUI
import UserNotifications

struct FlowView: View {
    @StateObject private var fm = FlowModel()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let width: Double = 250
    
    
    var body: some View {
        VStack {
            Text("Flow Productivity")
                .font(.headline)
            VStack {
                Text("\(fm.time)")
                    .font(.system(size: 70, weight: .medium, design: .rounded))
                    .padding()
                    .frame(width: width)
                    .background(.thinMaterial)
                    .cornerRadius(20)
                    .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.teal, lineWidth: 4))
                    .alert("Timer done!", isPresented: $fm.showingAlert) {
                        Button("Continue", role: .cancel) {
                            
                        }
                    }
                Slider(value: $fm.minutes, in:  1...60, step: 1)
                    .padding()
                    .frame(width: width)
                    .disabled(fm.isActive)
                    .animation(.easeInOut, value: fm.minutes)
                    .tint(.teal)
                HStack (spacing: 50){
                    Button(action: {fm.start(minutes: fm.minutes)}) {
                        HStack(spacing: 15){
                            Image(systemName: fm.isActive ? "pause.fill" : "play.fill")
                            Text(fm.isActive ? "Pause" : "Start")
                        }
                        .tint(.blue)
                    }
                    .disabled(fm.isActive)
                    
                    Button(action: {fm.reset()}) {
                        HStack(spacing: 15) {
                            Image(systemName: "arrow.clockwise")
                            Text("Reset")
                        }
                        .tint(.red)
                    }
                }
            }
            .onAppear {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) {
                    success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            .onReceive(timer) { _ in
                fm.updateCountdown()
            }
        }
    }
}

struct FlowView_Previews: PreviewProvider {
    static var previews: some View {
        FlowView()
    }
}
