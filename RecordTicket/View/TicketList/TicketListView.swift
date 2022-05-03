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
    
    @StateObject var vm = TicketListViewModel()
    @State private var alignmentCase: AlignmentCase = .recent
    
    @Binding var showRecordView: Bool
    
    @State private var deleteDialog = false
    @State private var deletingRecord: Record?
    @State private var editingRecord: Record?
    
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
                ForEach(vm.records, id: \.self) { record in
                    TicketView(record: record)
                        .padding(.vertical, 4)
                        .listRowSeparator(.hidden)
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                deletingRecord = record
                                deleteDialog = true
                            } label: {
                                Label("삭제", systemImage: "trash")
                            }
                            Button {
                                editingRecord = record
                            } label: {
                                Label("수정", systemImage: "pencil")
                            }
                        }
                }
            }
            .listStyle(.plain)
        }
        .confirmationDialog("정말로 해당 녹음을 삭제하시겠어요?", isPresented: $deleteDialog, presenting: deletingRecord) { record in
            Button("네", role: .destructive) {
                withAnimation {
                    vm.delete(record: record)
                }
            }
            
            Button("아니요", role: .cancel) {
                deleteDialog = false
            }
        }
        .sheet(item: $editingRecord) { record in
            ZStack {
                DecorateTicketView(record: record) {
                    editingRecord = nil
                    vm.getEntities()
                }
            }
        }
        .fullScreenCover(isPresented: $showRecordView, onDismiss: {
            withAnimation(.spring()) {
                vm.getEntities()
            }
        }) {
            RecordView()
        }
        .onAppear{
            UITableView.appearance().showsVerticalScrollIndicator = false
        }
    }
}

struct TicketListView_Previews: PreviewProvider {
    static var previews: some View {
        TicketListView(showRecordView: .constant(false))
    }
}
