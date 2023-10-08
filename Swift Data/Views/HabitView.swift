//
//  HabitView.swift
//  Swift Data
//
//  Created by Ben Hernes on 9/30/23.
//

import SwiftUI
import SwiftData

struct HabitView: View {
    @State private var isAnimate = false
    @State private var rotationDegrees: Double = 0
    @State private var isAddEditHabit = false
    @State private var isShowingDeleteAlert = false
    
    @Environment(\.modelContext) private var habitModelContext
    @Query() private var allHabits: [HabitItem]
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                
                if allHabits.isEmpty {
                    ContentUnavailableView("No projects",
                                           systemImage: "list.bullet.rectangle.portrait",
                                           description: Text("Add a project to get started"))
                }
                
                List {
                    Text("Projects are items that you want to save and make progress on in the long term")
                    .font(.footnote)
                    .foregroundStyle(.gray)
                    .italic()
                    
                    Text("If you select 'Daily reminder' when creating, the system will automatically create a daily task reminding you to make progress toward this project")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                        .italic()
                    
                    ForEach(allHabits) { habit in
                        NavigationLink {
                            HabitEditView(habit: habit)
                                .navigationTitle("Edit habit")
                                .navigationBarTitleDisplayMode(.inline)
                        } label: {
                            Text(habit.name)
                        }
                    }
                    .onDelete { indexes in
                        for index in indexes {
                            deleteHabit(habit: allHabits[index])
                        }
                    }
                    
                    Button {
                        vibrateStrong()
                        isShowingDeleteAlert.toggle()
                    } label: {
                        Text("Delete all")
                            .foregroundStyle(.red)
                    }
                }
                .listStyle(.plain)

                
                Button {
                    addHabit()

                } label: {
                    Image(systemName: "plus")
                        .font(.title)
                        .bold(true)
                        .foregroundStyle(.white)
                        .padding()
                        .frame(width: 65, height: 65)
                        .background(Color.black.gradient)
                        .rotationEffect(.degrees(rotationDegrees))
                        .clipShape(Circle())
                        .shadow(radius: 6)
                        .padding()
                }
                
            }
            
            .navigationTitle("Projects")
        }
        .sheet(isPresented: $isAddEditHabit) {
            NavigationStack {
                NewHabitView()
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                isAddEditHabit = false
                            } label: {
                                HStack {
                                    Text("Cancel")
                                }
                            }
                            
                        }
                    }
                    .navigationTitle("Add project")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .presentationDetents([.fraction(0.75)])
            .environment(\.colorScheme, .light)
        }
        
        .alert("Are you sure you want to delete all projects? This cannot be undone", isPresented: $isShowingDeleteAlert) {
            Button {
                // do nothing
            } label: {
                Text("Cancel")
            }
            
            Button {
                for habit in allHabits {
                    deleteHabit(habit: habit)
                }
            } label: {
                Text("Delete all")
            }
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
    
    func deleteHabit(habit: HabitItem) {
        vibrateDouble()
        habitModelContext.delete(habit)

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
