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
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) private var records: FetchedResults<Record>
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
                .onTapGesture {
                    let record = Record(context: viewContext)
                    record.title = "테스트1"
                    record.id = UUID()
                    record.location = "포항"
                    record.date = Date()
                    record.ticket = Ticket(context: viewContext)
                    record.ticket?.colorName = TicketColor.yellow.name
                    save()
                }
            
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
                ForEach(records) { record in
                    TicketView(record: record)
                    .padding(.vertical, 4)
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
        }
        
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

struct TicketListView_Previews: PreviewProvider {
    static var previews: some View {
        TicketListView()
    }
}
