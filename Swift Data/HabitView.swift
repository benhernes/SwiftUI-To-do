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
    @State private var isAddEditHabit = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                ContentUnavailableView("No habits",
                                       systemImage: "list.bullet.rectangle.portrait",
                                       description: Text("Add a habit to get started"))
                
                Button {
                    addHabit()

                } label: {
                    Image(systemName: "plus")
                        .font(.title)
                        .bold(true)
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
        .sheet(isPresented: $isAddEditHabit) {
            NavigationStack {
                NewHabitView()
            }
            .environment(\.colorScheme, .light)

        }
    }
    
    func addHabit() {
        vibrate()
        isAddEditHabit.toggle()
        withAnimation() {
            rotationDegrees += 90
            isAnimate.toggle()
        }
    }
    
    // MARK: System feedback
    func vibrate() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    func vibrateStrong() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    
    func vibrateDouble() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred(intensity: 100)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            generator.impactOccurred(intensity: 10)
        }
    }
}

//#Preview {
//    HabitView()
//}
