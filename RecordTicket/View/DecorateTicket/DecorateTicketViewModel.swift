//
//  DecorateTicketViewModel.swift
//  RecordTicket
//
//  Created by 김예훈 on 2022/05/03.
//

import Foundation
import UIKit

class DecorateTicketViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    
    func updateRecord(record: Record, title: String, color: TicketColor, shape: TicketShape) {
        record.title = title
        record.ticket?.colorName = color.name
        record.ticket?.shapeName = shape.name
        manager.save()
    }
}
