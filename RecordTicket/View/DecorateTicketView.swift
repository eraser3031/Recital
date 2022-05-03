//
//  DecorateTicketView.swift
//  RecordTicket
//
//  Created by 김예훈 on 2022/04/27.
//

import SwiftUI
import PhotosUI

struct DecorateTicketView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var decoCase: DecoCase = .shape
    
    @State private var title: String = ""
    @State private var color: TicketColor = .pink
    @State private var images: [UIImage] = []
    @State private var shape: TicketShape = .innerRounded
    
    var record: Record
    
    @State private var showPhotoPicker = false
    
    let dismiss: (() -> Void)?
    
    private let colorColumns = [GridItem](repeating: GridItem(spacing: 20), count: 4)
    private let shapeColumns = [GridItem](repeating: GridItem(spacing: 30), count: 3)
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    Spacer()
                    
//                    TicketView(title: title, date: Date(), location: "포항", length: DateInterval(start: Date(), end: Date()))
//                        .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        CapsulePicker(selected: $decoCase)
                            .padding(.horizontal, 20)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 28, style: .continuous)
                                .fill(Color(.systemBackground))
                            
                            if decoCase == .title {
                                titleBox
                            } else if decoCase == .color {
                                colorBox
                                    .padding(.horizontal, 30)
                            } else if decoCase == .image {
                                imageBox
                            } else {
                                shapeBox
                                    .padding(.horizontal, 40)
                            }
                        }
                    }
                    .frame(maxWidth: 400)
                    .frame(maxHeight: 320)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(role: .cancel) {
                        if let dismiss = dismiss {
                            dismiss()
                        }
                    } label: {
                        Text("취소")
                            .foregroundColor(.red)
                    }
                    .buttonStyle(.plain)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(role: .destructive) {
                        updateRecord()
                        if let dismiss = dismiss {
                            dismiss()
                        }
                    } label: {
                        Text("완료")
                            .bold()
                    }
                    .buttonStyle(.plain)
                }
            }
            .navigationTitle("티켓 꾸미기")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private var titleBox: some View {
        TextField("제목을 적어주세요", text: $title)
            .font(.title3)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 20)
    }
    
    private var colorBox: some View {
        LazyVGrid(columns: colorColumns, spacing: 20) {
            ForEach(TicketColor.allCases) { ticketColor in
                Circle()
                    .fill(ticketColor.color)
                    .frame(width: 58, height: 58)
                    .overlay(
                        Circle()
                            .strokeBorder(.primary,
                                          lineWidth: color == ticketColor ? 4 : 0)
                            .frame(width: 58, height: 58)
                    )
                    .onTapGesture {
                        withAnimation(.interactiveSpring()) {
                            color = ticketColor
                        }
                    }
            }
        }
    }
    
    private var imageBox: some View {
        VStack(spacing: 40) {
            Circle()
                .fill(Color(.systemGray6))
                .frame(width: 80, height: 80)
                .overlay(
                    ZStack{
                        Image(systemName: "plus")
                            .font(.largeTitle.weight(.semibold))
                        
                        if let image = images.first {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                        }
                    }
                )
            
            Text(images.count == 0 ? "배경을 추가해주세요" : "배경을 바꾸려면 탭하세요")
                .font(.headline.weight(.bold))
        }
        .contentShape(Rectangle())
        .onTapGesture {
            showPhotoPicker = true
        }
        .sheet(isPresented: $showPhotoPicker) {
            let configuration = PHPickerConfiguration.config
            PhotoPicker(configuration: configuration,
                        images: $images,
                        isPresented: $showPhotoPicker)
        }
    }
    
    private var shapeBox: some View {
        LazyVGrid(columns: shapeColumns, spacing: 30) {
            ForEach(TicketShape.allCases) { ticketShape in
                ticketShape
                    .makeShape(color: ticketShape == shape ? color.color : Color(.systemGray6))
                    .frame(width: 64, height: 64)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            shape = ticketShape
                        }
                    }
            }
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
    
    private func updateRecord() {
        record.title = title
        record.ticket?.colorName = color.name
        record.ticket?.shapeName = shape.name
        save()
    }
}

enum DecoCase: String, Identifiable, CaseIterable {
    case title
    case color
    case image
    case shape
    
    var id: String {
        self.rawValue
    }
    
    var name: String {
        self.rawValue
    }
}

struct CapsulePicker: View {
    
    @Binding var selected: DecoCase
    
    var body: some View {
        HStack(spacing: 0) {
            
            ForEach(DecoCase.allCases) { decoCase in
                GeometryReader { geo in
                    Text(decoCase.name)
                        .font(.subheadline.bold())
                        .foregroundColor(decoCase == selected ? .primary : .gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .contentShape(Capsule())
                        .onTapGesture {
                            withAnimation(.spring()) {
                                selected = decoCase
                            }
                        }
                }
                .frame(height: 40)
            }
        }
        .background(
            GeometryReader { geo in
                Capsule()
                    .fill(Color(.systemBackground))
                    .frame(width: geo.size.width / 4)
                    .frame(maxWidth: getCapsuleWidth(width: geo.size.width), alignment: .trailing)
            }
                .frame(maxWidth: .infinity)
        )
    }
    
    private func getCapsuleWidth(width: CGFloat) -> CGFloat {
        switch selected {
        case .title:
            return width / 4
        case .color:
            return width / 2
        case .image:
            return width / 4 * 3
        case .shape:
            return width
        }
    }
}

//struct DecorateTicketView_Previews: PreviewProvider {
//    static var previews: some View {
//        DecorateTicketView(){}
//    }
//}
