//
//  Job_todayApp.swift
//  Job today
//
//  Created by Test on 25/11/26.
//

import SwiftUI
import CoreData

@main
struct Job_todayApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
