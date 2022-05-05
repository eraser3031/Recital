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
    
    func updateRecord(record: Record, title: String, color: TicketColor, image: UIImage?, shape: TicketShape) {
        record.title = title
        record.ticket?.colorName = color.name
        if let image = image {
            record.ticket?.imageName = ImageManager.instance.saveImage(uiImage: image)
        }
        record.ticket?.shapeName = shape.name
        manager.save()
    }
}
