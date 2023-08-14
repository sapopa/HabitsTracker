//
//  AddHabitView.swift
//  HabitsTracker
//
//  Created by sebastian.popa on 8/12/23.
//

import SwiftUI

struct AddHabitView: View {
    
    @State private var habitName = ""
    @State private var habitDescription = ""
    @State private var isGoodHabit = true
    @State private var targetToReach = 1
    @State private var periodOfTimeForHabit: PeriodOfTime = .day
    
    @State private var formCompletionAlert = false
    @State private var formCompletionAlertMessage = ""
    
    @State private var isFormValid = false
    
    @ObservedObject var habits: Habits
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                TextField("Habit Name", text: $habitName)
                
                TextField("Habit description", text: $habitDescription)
                
                Toggle("Is it a good habit?", isOn: $isGoodHabit)
                    .onTapGesture {
                        targetToReach = 1
                        periodOfTimeForHabit = .day
                    }
                
                Stepper(value: $targetToReach, in: isGoodHabit ? 1...Int.max : 0...Int.max) {
                    VStack (alignment: .leading){
                        Text(isGoodHabit ? "Minimum occurence" : "Maximum occurence")
                        Text("Target: \(targetToReach)")
                    }
                }
                
                Picker("Period of time", selection: $periodOfTimeForHabit) {
                    ForEach(PeriodOfTime.allCases, id: \.self){ period in
                        Text(period.localizedName)
                    }
                }
                
                HStack {
                    Spacer()
                    
                    FormButton(title: "Add", backgroundColor: .green, action: formValidation)
                        .alert("Form filling error", isPresented: $formCompletionAlert) {
                            
                        } message: {
                            Text(formCompletionAlertMessage)
                    }
                    
                    FormButton(title: "Reset", backgroundColor: .red, action: resetForm)
                    
                    Spacer()
                }
                .buttonStyle(BorderlessButtonStyle())
            }
        }
    }
    
    func formValidation() {
        let trimmedHabitName = habitName.trimmingCharacters(in: .whitespaces)
        let trimmedHabitDescription = habitDescription.trimmingCharacters(in: .whitespaces)
        if trimmedHabitName.isEmpty {
            formCompletionAlertMessage = "Please fill out the habit name"
            formCompletionAlert.toggle()
            return
        }
        if trimmedHabitDescription.isEmpty {
            formCompletionAlertMessage = "Please fill out a description for your habit"
            formCompletionAlert.toggle()
            return
        }
        if habits.list.contains(where: { habit in
            habit.name == trimmedHabitName.capitalized}) {
            formCompletionAlertMessage = "You already have this habit listed"
            formCompletionAlert.toggle()
            return
        }
        isFormValid = true
        
        habits.list.append(Habit(name: trimmedHabitName.capitalized, description: trimmedHabitDescription, isGoodHabit: isGoodHabit, targetOfOccurences: targetToReach, timeframe: periodOfTimeForHabit))
        
        dismiss()
    }
    
    func resetForm() {
        habitName = ""
        habitDescription = ""
        isGoodHabit = true
        targetToReach = 0
        periodOfTimeForHabit = .day
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView(habits: Habits())
    }
}
