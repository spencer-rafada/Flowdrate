//
//  DrinkWaterView.swift
//  Flowdrate
//
//  Created by Spencer Rafada on 10/25/22.
//

import SwiftUI

struct DrinkWaterView: View {
    @StateObject private var wm = DrinkWaterModel()
    var body: some View {
        VStack (spacing: 30) {
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
            VStack (spacing: 20) {
                Text("\(wm.message)")
                HStack {
                    ForEach(0..<wm.number, id: \.self) {_ in
                        Image(systemName: "drop.fill")
                            .foregroundColor(.teal)
                    }
                }
                .fixedSize(horizontal: true, vertical: false)
                .frame(maxWidth: 250)
            }
        }
    }
}

struct DrinkWaterView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkWaterView()
    }
}
