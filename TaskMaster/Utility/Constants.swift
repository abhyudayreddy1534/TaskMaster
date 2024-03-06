//
//  Constants.swift
//  TaskMaster
//
//  Created by Sravanthi Chinthireddy on 05/03/24.
//

import SwiftUI

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

// MARK: - UI

var backgroundGradient : LinearGradient {
    return LinearGradient(colors: [.pink, .blue],
                          startPoint: .topLeading,
                          endPoint: .bottomTrailing)
}
