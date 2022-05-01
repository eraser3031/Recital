//
//  RecordTicketApp.swift
//  RecordTicket
//
//  Created by 김예훈 on 2022/04/25.
//

import SwiftUI

@main
struct RecordTicketApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
