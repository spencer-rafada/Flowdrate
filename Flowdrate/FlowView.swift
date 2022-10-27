//
//  FlowView.swift
//  Flowdrate
//
//  Created by Spencer Rafada on 10/24/22.
//

import SwiftUI

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
                
                Slider(value: $fm.minutes, in:  1...60, step: 1)
                    .padding()
                    .frame(width: width)
                    .disabled(fm.isActive)
                    .animation(.easeInOut, value: fm.minutes)
                    .tint(.teal)
                HStack (spacing: 50){
                    Button(action: {fm.start(minutes: fm.minutes)}) {
                        HStack(spacing: 15){
                            Image(systemName: "play.fill")
                            Text("Start")
                        }
                        .tint(.blue)
                    }
                    .disabled(fm.isActive)
                   
                    /* Pause Feature
                    Button(action: {fm.pauseResume()}) {
                        HStack(spacing: 15){
                            Image(systemName: "pause.fill")
                            Text("Pause")
                        }
                        .tint(.blue)
                    }
                    .disabled(!fm.isActive)
                     */
                    
                    Button(action: {fm.reset()}) {
                        HStack(spacing: 15) {
                            Image(systemName: "arrow.clockwise")
                            Text("Reset")
                        }
                        .tint(.red)
                    }
                    .disabled(!fm.isActive)
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
        NavigationView {
            FlowView()
        }
    }
}
