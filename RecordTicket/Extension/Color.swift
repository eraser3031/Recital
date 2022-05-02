//
//  Color.swift
//  RecordTicket
//
//  Created by 김예훈 on 2022/04/28.
//

import SwiftUI

enum TicketColor: String, Identifiable, CaseIterable {
    case pink
    case deepPink
    case red
    case yellow
    case mint
    case softBlue
    case deepBlue
    case purple
    
    var id: String {
        self.rawValue
    }
    
    var name: String {
        self.rawValue
    }
    
    var color: Color {
        switch self {
        case .pink:
            return Color("Pink")
        case .deepPink:
            return Color("DeepPink")
        case .deepBlue:
            return Color("DeepBlue")
        case .red:
            return Color("Red")
        case .yellow:
            return Color("Yellow")
        case .mint:
            return Color("Mint")
        case .softBlue:
            return Color("SoftBlue")
        case .purple:
            return Color("Purple")
        }
    }
}
