//
//  TicketListView.swift
//  RecordTicket
//
//  Created by 김예훈 on 2022/04/27.
//

import SwiftUI

enum AlignmentCase: String, CaseIterable {
    case recent
    case played
}

struct TicketListView: View {
    
    @State private var alignmentCase: AlignmentCase = .recent
    
    init() {
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Tickets")
                .scaledFont(name: CustomFont.gilroyExtraBold, size: 28)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 40)
            
            HStack(spacing: 16) {
                Text("최근 순")
                    .scaledFont(name: CustomFont.gothicNeoExBold, size: 17)
                    .foregroundColor(alignmentCase == .recent ? .primary : Color(.systemGray4))
                    .onTapGesture {
                        withAnimation(.spring()) {
                            alignmentCase = .recent
                        }
                    }
                
                Text("감상 순")
                    .scaledFont(name: CustomFont.gothicNeoExBold, size: 17)
                    .foregroundColor(alignmentCase == .played ? .primary : Color(.systemGray4))
                    .onTapGesture {
                        withAnimation(.spring()) {
                            alignmentCase = .played
                        }
                    }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 30).padding(.bottom, 10)
            
            List {
                ForEach(0..<3) { index in
                    let sample = SampleData.tickets[index % 3]
                    TicketView(title: sample.title, date: sample.date, location: sample.location, length: sample.length
                               ,color: SampleData.colors[index % 3])
                    .padding(.vertical, 4)
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
        }
    }
}

struct TicketListView_Previews: PreviewProvider {
    static var previews: some View {
        TicketListView()
    }
}
