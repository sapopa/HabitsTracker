//
//  PeriodOfTime.swift
//  HabitsTracker
//
//  Created by sebastian.popa on 8/12/23.
//

import Foundation
import SwiftUI

enum PeriodOfTime: String, Codable, Equatable, CaseIterable {
    case day = "Day", week = "Week", month = "Month", year = "Year"
    
    var localizedName: LocalizedStringKey {
        LocalizedStringKey(rawValue)
    }
}
