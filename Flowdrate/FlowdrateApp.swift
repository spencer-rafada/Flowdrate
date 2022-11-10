//
//  FlowdrateApp.swift
//  Flowdrate
//
//  Created by Spencer Rafada on 10/24/22.
//

import SwiftUI

@main
struct FlowdrateApp: App {
    @State private var vm = DrinkWaterModel()
    @State private var fm = FlowModel()
    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .environmentObject(vm)
                .environmentObject(fm)
        }
    }
}
