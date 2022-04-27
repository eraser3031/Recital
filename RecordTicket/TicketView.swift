//
//  TicketView.swift
//  RecordTicket
//
//  Created by 김예훈 on 2022/04/26.
//

import SwiftUI

struct SampleData {
    static let tickets: [(title: LocalizedStringKey, date: Date, location: LocalizedStringKey, length: DateInterval)] = [
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

enum TicketCase: String {
    case innerRounded
    case rectangle
    case rounded
}

struct TicketView: View {
    
    @State private var showDialog = false
    
    var title: LocalizedStringKey
    var date: Date
    var location: LocalizedStringKey
    var length: DateInterval
    
    var color: Color = .init(hex: 0xf7b0be)
    var ticketCase: TicketCase = .innerRounded
    var cornerRadius: CGFloat = 9
    
    var body: some View {
        
        HStack(spacing: 0){
            mainPart
            subPart
        }
        .aspectRatio(2.5, contentMode: .fit)
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                showDialog = true
            } label: {
                Label("Delete", systemImage: "trash")
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(.gray)
                    )
            }
            Button { print("hi2") } label: {
                Label("Flag", systemImage: "flag")
            }
        }
        .confirmationDialog("정말로 해당 녹음을 삭제하시겠어요?", isPresented: $showDialog, titleVisibility: .visible) {
            Button("네", role: .destructive) {
                print("Delete")
            }
            
            Button("아니요", role: .cancel) {
                showDialog = false
            }
        }
    }
    
    private var mainPart: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .scaledFont(name: CustomFont.gothicNeoHeavy, size: 17)
                .lineLimit(1)
            
            Spacer()
            
            HStack(alignment: .bottom) {
                Text(date, format: .dateTime)
                
                Spacer()
                
                Text(location)
            }
            .font(.subheadline)
        }
        .padding()
        .background(
            InnerRoundedRectangle(cornerRadius: cornerRadius)
                .fill(color)
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
                    .fill(color)
            )
            .overlay(
                VLine()
                    .stroke(Color(.systemBackground), style: .init(lineWidth: 2, dash: [8, 8]))
                    .frame(width: 1)
                    .padding(.vertical, cornerRadius)
                ,alignment: .leading
            )
    }
}

struct TicketView_Previews: PreviewProvider {
    static var previews: some View {
        TicketView(title: "여수밤바다 파도소리", date: Date(), location: "Gongju", length: DateInterval(start: Date(), end: Date()) )
            .previewInterfaceOrientation(.portrait)
    }
}
