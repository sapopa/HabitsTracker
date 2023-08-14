//
//  HabitDetailsView.swift
//  HabitsTracker
//
//  Created by sebastian.popa on 8/13/23.
//

import SwiftUI

struct HabitDetailsView: View {
    var habit: Habit
    
    @ObservedObject var habits: Habits
    
    @State private var occurences = 0
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    VStack {
                        Text("Goal: \(habit.targetOfOccurences) times per \(habit.timeframe.rawValue.lowercased())")
                            .font(.title)
                            .foregroundColor(goalColor())
                        HStack {
                            Text("This \(habit.timeframe.rawValue.lowercased()): \(occurences)")
                                .font(.title2)
                                .foregroundColor(occurencesColor())
                            
                            Stepper(value: $occurences, in: 0...Int.max) {
                                
                            }
                        }
                    }
                    .habitDetailsCellDesign()
                    .padding(.bottom, 30)
                    Group {
                        if habit.isGoodHabit {
                            if habit.targetOfOccurences > occurences {
                                Text("You need \(habit.targetOfOccurences - occurences) more occurences to achieve your goal")
                            } else {
                                Text("You've reached your minimum goal! 🥳")
                            }
                        } else {
                            if habit.targetOfOccurences > occurences {
                                Text("You will surpass your allowed limit if it occures \(habit.targetOfOccurences - occurences) more times")
                            } else {
                                Text("You surpassed your maximum goal 😰")
                            }
                        }
                    }
                    .font(.title)
                    .foregroundColor(occurencesColor())
                    .habitDetailsCellDesign()
                    .padding(.bottom, 50)
                    
                    VStack {
                        Section {
                            Text(habit.description)
                        } header: {
                            Text("Habit description")
                                .font(.title)
                                .padding(.bottom, 10)
                        }
                    }
                    .habitDetailsCellDesign()
                }
                .padding()
            }
            .navigationTitle(habit.name)
            .padding(.top)
        }
        .onAppear {
            occurences = habit.numberOfOccurences
        }
        .onDisappear {
            updateHabit()
        }
    }
    
    func goalColor() -> Color {
        if habit.isGoodHabit {
            return Color.green
        }
        return Color.red
    }
    
    func occurencesColor() -> Color {
        if habit.isGoodHabit{
            if habit.targetOfOccurences > occurences {
                return Color.red
            }
            return Color.green
        } else {
            if habit.targetOfOccurences > occurences {
                return Color.green
            }
            return Color.red
        }
    }
    
    func updateHabit() {
        let index = habits.list.firstIndex(of: habit)!
        habits.list[index].numberOfOccurences = occurences
    }
}

struct HabitDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetailsView(habit: Habit(name: "Workout", description: "I love going out to the gym", isGoodHabit: true, targetOfOccurences: 4, timeframe: .week, numberOfOccurences: 3), habits: Habits())
    }
}
