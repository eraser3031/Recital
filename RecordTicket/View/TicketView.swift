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
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(color)
        case .moreRounded:
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(color)
        case .edge:
            Rectangle()
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
    var color: Color {
        get {
            guard let ticketColor = TicketColor.allCases.first(where: { $0.name == colorName ?? "" }) else {
                return TicketColor.pink.color
            }
            return ticketColor.color
        }
    }
}

struct TicketView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var record: Record
    
    @State private var showDialog = false
    @State private var showPlayer = false
    
    var cornerRadius: CGFloat = 9
    
    var body: some View {
        
        HStack(spacing: 0){
            mainPart
            subPart
        }
        .onTapGesture {
            showPlayer = true
        }
        .fullScreenCover(isPresented: $showPlayer) {
            PlayerView(record: record)
        }
        .aspectRatio(2.5, contentMode: .fit)
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                showDialog = true
            } label: {
                Label("삭제", systemImage: "trash")
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(.gray)
                    )
            }
            Button { print("hi2") } label: {
                Label("수정", systemImage: "pencil")
            }
        }
        .confirmationDialog("정말로 해당 녹음을 삭제하시겠어요?", isPresented: $showDialog, titleVisibility: .visible) {
            Button("네", role: .destructive) {
                withAnimation(.spring()) {                
                    viewContext.delete(record)
                    save()
                }
            }
            
            Button("아니요", role: .cancel) {
                showDialog = false
            }
        }
    }
    
    private var mainPart: some View {
        VStack(alignment: .leading) {
            Text(record.title ?? "")
                .font(.headline)
                .scaledFont(name: CustomFont.gothicNeoHeavy, size: 17)
                .lineLimit(1)
            
            Spacer()
            
            HStack(alignment: .bottom) {
                Text(record.date ?? Date(), format: .dateTime)
                
                Spacer()
                
                Text(record.location ?? "")
            }
            .font(.subheadline)
        }
        .padding()
        .background(
            InnerRoundedRectangle(cornerRadius: cornerRadius)
                .fill(record.ticket?.color ?? TicketColor.pink.color)
        )
    }
    
    private var subPart: some View {
        Text("10:23")
            .fontWeight(.heavy)
            .rotationEffect(Angle(degrees: -90))
            .padding()
            .frame(maxHeight: .infinity)
            .background(
                InnerRoundedRectangle(cornerRadius: cornerRadius)
                    .fill(record.ticket?.color ?? TicketColor.pink.color)
            )
            .overlay(
                VLine()
                    .stroke(Color(.systemBackground), style: .init(lineWidth: 2, dash: [8, 8]))
                    .frame(width: 2)
                    .padding(.vertical, cornerRadius)
                ,alignment: .leading
            )
    }
    
    private func save() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

}

//struct TicketView_Previews: PreviewProvider {
//    static var previews: some View {
//        TicketView(record: <#T##Record#>)
//            .padding()
//            .previewLayout(.sizeThatFits)
//    }
//}
