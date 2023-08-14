//
//  CustomComponents.swift
//  HabitsTracker
//
//  Created by sebastian.popa on 8/13/23.
//

import Foundation
import SwiftUI

struct FormButton: View {
    
    let title: String
    let backgroundColor: Color
    let action : () -> Void
    
    var body: some View {
        Button(title, action: action)
        .frame(width: 80, height: 40)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .foregroundColor(.white)
    }
}

extension View {
    func habitDetailsCellDesign() -> some View {
        self
            .padding()
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
