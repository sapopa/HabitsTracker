//
//  Habits.swift
//  HabitsTracker
//
//  Created by sebastian.popa on 8/13/23.
//

import Foundation

class Habits: ObservableObject {
    @Published var list = [Habit]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(list) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
    }
    
    init(){
        if let savedHabits = UserDefaults.standard.data(forKey: "Habits") {
            if let decoded = try? JSONDecoder().decode([Habit].self, from: savedHabits){
                list = decoded
                return
            }
        }
        list = []
    }
}
