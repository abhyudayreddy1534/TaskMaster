//
//  TaskMasterApp.swift
//  TaskMaster
//
//  Created by Sravanthi Chinthireddy on 05/03/24.
//

import SwiftUI

@main
struct TaskMasterApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
