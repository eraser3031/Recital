//
//  RecordViewModel.swift
//  RecordTicket
//
//  Created by 김예훈 on 2022/05/03.
//

import Foundation

class RecordViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    
    func addRecord(fileName: String, length: String, location: String) -> Record {
        let newRecord = Record(context: manager.context)
        newRecord.id = UUID()
        newRecord.fileName = fileName
        newRecord.length = length
        newRecord.location = location
        newRecord.date = Date()
        
        let newTicket = Ticket(context: manager.context)
        newTicket.shapeName = TicketShape.rectangle.name
        newRecord.ticket = newTicket
        
        manager.save()
        return newRecord
    }
}
