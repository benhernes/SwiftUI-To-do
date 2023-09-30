//
//  HabitView.swift
//  Swift Data
//
//  Created by Ben Hernes on 9/30/23.
//

import SwiftUI

struct HabitView: View {
    @State private var isAnimate = false
    @State private var rotationDegrees: Double = 0
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                ContentUnavailableView("No habits",
                                       systemImage: "list.bullet.rectangle.portrait",
                                       description: Text("Add a habit to get started"))
                
                Button {
                    //Add tasks
                    withAnimation() {
                        rotationDegrees += 90
                        isAnimate.toggle()
                    }
                } label: {
                    Image(systemName: "plus")
                        .font(.title)
                        .bold(isAnimate ? true : false)
                        .foregroundStyle(.white)
                        .padding()
                        .frame(width: 65, height: 65)
                        .background(Color.blue.gradient)
                        .rotationEffect(.degrees(rotationDegrees))
                        .clipShape(Circle())
                        .shadow(radius: 6)
                        .padding()
                }
                
            }
            
            .navigationTitle("Habits")
        }
    }
}

//#Preview {
//    HabitView()
//}
