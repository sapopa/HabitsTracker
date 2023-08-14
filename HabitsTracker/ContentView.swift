//
//  ContentView.swift
//  HabitsTracker
//
//  Created by sebastian.popa on 8/12/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isHabitsFormShown = false;
    @StateObject private var habits = Habits()
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(habits.list.reversed()) { habit in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(habit.name)
                                    .font(.headline)
                                    .foregroundColor(habit.isGoodHabit ? .green : .red)
                                Text("\(habit.numberOfOccurences) times this \(habit.timeframe.rawValue.lowercased())")
                                    .font(.subheadline)
                            }
                            NavigationLink {
                                HabitDetailsView(habit: habit, habits: habits)
                            } label: {}
                        }
                    }
                    .onDelete(perform: removeHabits)
                }
            }
            .navigationTitle("Habits Tracker")
            .toolbar {
                Button {
                    isHabitsFormShown.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                .padding(.top)
            }
            .sheet(isPresented: $isHabitsFormShown) {
                AddHabitView(habits: habits)
            }
        }
    }
    
    func removeHabits(at offsets: IndexSet){
        let habit = habits.list.reversed()[offsets.first!]
        if let index = habits.list.firstIndex(of: habit) {
            habits.list.remove(at: index)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
