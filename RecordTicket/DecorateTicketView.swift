//
//  DecorateTicketView.swift
//  RecordTicket
//
//  Created by 김예훈 on 2022/04/27.
//

import SwiftUI
import PhotosUI

struct DecorateTicketView: View {
    
//    @Environment(\.dismiss) var dismiss
    @State private var decoCase: DecoCase = .image
    @State private var title: String = ""
    @State private var images: [UIImage] = []
    @State private var showPhotoPicker = false
    let dismiss: (() -> Void)?
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Color(.systemGray6)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    Spacer()
                    
                    TicketView(title: LocalizedStringKey(title), date: Date(), location: "포항", length: DateInterval(start: Date(), end: Date()))
                        .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    CapsulePicker(selected: $decoCase)
                        .padding(.horizontal, 20)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 28, style: .continuous)
                            .fill(Color(.systemBackground))
                        
                        if decoCase == .title {
                            TextField("제목을 적어주세요", text: $title)
                                .font(.title3)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)
                            
                        } else if decoCase == .color {
                            
                        } else if decoCase == .image {
                            VStack(spacing: 40) {
                                
                                Spacer()
                                
                                Circle()
                                    .fill(Color(.systemGray6))
                                    .frame(width: 150, height: 150)
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
                                
                                Spacer()
                            }
                            .foregroundColor(Color(.systemGray4))
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
                        } else {
                            
                        }
                    }
                    .frame(maxWidth: 400)
                    .frame(maxHeight: 300)
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

struct DecorateTicketView_Previews: PreviewProvider {
    static var previews: some View {
        DecorateTicketView(){}
    }
}
