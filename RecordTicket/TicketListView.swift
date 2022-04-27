//
//  TicketListView.swift
//  RecordTicket
//
//  Created by 김예훈 on 2022/04/27.
//

import SwiftUI

struct TicketListView: View {
    var body: some View {
        VStack {
            Text("Tickets")
                .scaledFont(name: CustomFont.gilroyExtraBold, size: 28)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 40)
            
            List {
                ForEach(0..<3) { index in
                    let sample = SampleData.tickets[index]
                    TicketView(title: sample.title, date: sample.date, location: sample.location, length: sample.length
                               ,color: SampleData.colors[index])
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
