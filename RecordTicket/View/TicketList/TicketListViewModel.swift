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
    
    let manager = CoreDataManager.instance
    
    init() {
        getEntities()
    }
    
    func getEntities() {
        let request = NSFetchRequest<Record>(entityName: "Record")
        
        do {
            records = try manager.context.fetch(request)
            records.forEach { record in
                print(record.ticket?.colorName ?? "-")
            }
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
