//
//  TicketListViewModel.swift
//  RecordTicket
//
//  Created by 김예훈 on 2022/05/03.
//

import Foundation
import CoreData
import SwiftUI

class TicketListViewModel: ObservableObject {
    
    @Published var records: [Record] = []
    @Published var alignCase: AlignmentCase = .recent
    
    let manager = CoreDataManager.instance
    
    init() {
        getEntities()
    }
    
    func getEntities() {
        let request = NSFetchRequest<Record>(entityName: "Record")
        var sort = NSSortDescriptor(keyPath: \Record.title, ascending: true)
        if alignCase == .played {
            sort = NSSortDescriptor(keyPath: \Record.length, ascending: true)
        }
        request.sortDescriptors = [sort]
        do {
            records = try manager.context.fetch(request)
        } catch let error {
            print("\(error)")
        }
    }
    
    func delete(record: Record) {
        manager.context.delete(record)
        manager.save()
        withAnimation {
            getEntities()
        }
    }
}
