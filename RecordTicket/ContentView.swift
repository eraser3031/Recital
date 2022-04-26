//
//  ContentView.swift
//  RecordTicket
//
//  Created by 김예훈 on 2022/04/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Records")
                .font(.title.weight(.heavy))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.top, .horizontal], 20)
                .padding(.vertical, 20)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(0..<3) { index in
                        let sample = SampleData.tickets[index]
                        TicketView(title: sample.title, date: sample.date, location: sample.location, length: sample.length
                                   ,color: SampleData.colors[index])
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
