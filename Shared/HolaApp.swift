//
//  HolaApp.swift
//  Shared
//
//  Created by Aidan Pendlebury on 08/01/2021.
//

import SwiftUI

@main
struct HolaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
