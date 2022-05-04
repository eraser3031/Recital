//
//  TicketView.swift
//  RecordTicket
//
//  Created by 김예훈 on 2022/04/26.
//

import SwiftUI

struct SampleData {
    static let tickets: [(title: String, date: Date, location: LocalizedStringKey, length: DateInterval)] = [
        ("여수밤바다 파도소리", Date(), location: "Gongju", length: DateInterval(start: Date(), end: Date())),
        ("제민천 공원의 새소리", Date(), location: "Yeosu", length: DateInterval(start: Date(), end: Date())),
        ("카페에서", Date(), location: "Seoul", length: DateInterval(start: Date(), end: Date()))
    ]
    
    static let colors: [Color] = [
        Color(hex: 0xf7b0be),
        Color(hex: 0xfac92c),
        Color(hex: 0xf15a42)
    ]
}

enum TicketShape: String, Identifiable, CaseIterable {
    case innerRounded
    case rectangle
    case rounded
    case moreRounded
    case edge
    
    var id: String {
        self.rawValue
    }
    
    var name: String {
        self.rawValue
    }
    
    @ViewBuilder
    func makeShape(color: Color) -> some View {
        switch self {
        case .innerRounded:
            InnerRoundedRectangle(cornerRadius: 12)
                .fill(color)
        case .rectangle:
            Rectangle()
                .fill(color)
        case .rounded:
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(color)
        case .moreRounded:
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(color)
        case .edge:
            EdgeRectangle()
                .fill(color)
        }
    }
}

enum TicketCase: String {
    case innerRounded
    case rectangle
    case rounded
}

extension Ticket {
    
    var ticketShape: TicketShape {
        guard let ticketShape = TicketShape.allCases.first(where: { $0.name == shapeName ?? "" }) else {
            return TicketShape.rectangle
        }
        return ticketShape
    } 
    
    var color: Color {
        ticketColor.color
    }
    
    var ticketColor: TicketColor {
        get {
            guard let ticketColor = TicketColor.allCases.first(where: { $0.name == colorName ?? "" }) else {
                return TicketColor.pink
            }
            return ticketColor
        }
    }
}

struct TicketView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var record: Record
    
    @State private var showDialog = false
    @State private var showDecorate = false
    @State private var showPlayer = false
    
    var cornerRadius: CGFloat = 8
    
    var body: some View {
        
        HStack(spacing: 0){
            mainPart
            subPart
        }
        .overlay(
            Image("NoiseTexture")
                .opacity(0.12)
                .blendMode(colorScheme == .light ? .lighten : .overlay)
        )
        .onTapGesture {
            showPlayer = true
        }
        .fullScreenCover(isPresented: $showPlayer) {
            PlayerView(record: record)
        }
        .aspectRatio(2.5, contentMode: .fit)
    }
    
    private var mainPart: some View {
        VStack(alignment: .leading) {
            Text(record.title ?? "")
//                .font(.headline)
                .scaledFont(name: CustomFont.gothicNeoExBold, size: 17)
                .lineLimit(1)
            
            Spacer()
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text(record.date ?? Date(), format: Date.FormatStyle(date: .long, time: .omitted) )
                        .font(.subheadline.weight(.semibold))
                    Text(record.date ?? Date(), format: Date.FormatStyle(date: .omitted, time: .shortened) )
                        .font(.subheadline.weight(.semibold))
                }
                     
                Spacer()
                
                Text(record.location ?? "위치정보 없음")
                    .font(.subheadline.weight(.semibold))
            }
            .font(.subheadline)
        }
        .padding(20)
        .background(
            record.ticket?.ticketShape
                .makeShape(color: record.ticket?.color ?? Color(.systemGray6))
        )
    }
    
    private var subPart: some View {
        Text(record.length ?? "00:00")
            .fontWeight(.heavy)
            .rotationEffect(Angle(degrees: -90))
            .padding()
            .frame(maxHeight: .infinity)
            .background(
                record.ticket?.ticketShape
                    .makeShape(color: record.ticket?.color ?? Color(.systemGray6))
            )
            .overlay(
                VLine()
                    .stroke(Color(.systemBackground), style: .init(lineWidth: 2, dash: [8, 8]))
                    .frame(width: 12)
                    .padding(.vertical, cornerRadius)
                ,alignment: .leading
            )
    }
}



//struct TicketView_Previews: PreviewProvider {
//    static var previews: some View {
//        TicketView(record: <#T##Record#>)
//            .padding()
//            .previewLayout(.sizeThatFits)
//    }
//}
