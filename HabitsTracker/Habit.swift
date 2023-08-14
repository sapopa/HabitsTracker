//
//  Habit.swift
//  HabitsTracker
//
//  Created by sebastian.popa on 8/13/23.
//

import Foundation

struct Habit: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let description: String
    let isGoodHabit: Bool
    let targetOfOccurences: Int
    let timeframe: PeriodOfTime
    var numberOfOccurences = 0
}
