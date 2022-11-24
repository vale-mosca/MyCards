//
//  MyCards2App.swift
//  MyCards2
//
//  Created by Valerio Mosca on 19/11/22.
//

import SwiftUI

@main
struct MyCardsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
