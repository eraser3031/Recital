//
//  RecordView.swift
//  RecordTicket
//
//  Created by 김예훈 on 2022/04/27.
//

import SwiftUI
import AVKit

struct RecordView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject var rm = RecordManager()
    @StateObject var tm = TimerManager()
    @StateObject var lm = LocationManager()
    
    @Environment(\.dismiss) var dismiss
    @State private var showDecorateTicketView = false
    @State private var showDialog = false
    @State var ani = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 8) {
                    Text(lm.placemark?.subLocality ?? "위치정보 없음")
                        .font(.title.bold())
                        .padding(.top, 20)
                    
                    Text(Date(), format: Date.FormatStyle(date: .omitted, time: .shortened))
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                VStack(spacing: 20) {
                    recordCircle
                        .frame(width: 246, height: 246)
                    
                    Text("00:00.00")
                        .font(.system(size: 54, weight: .bold, design: .rounded))
                        .opacity(0)
                        .overlay(alignment: .leading) {
                            Text("\(tm.minutesString):\(tm.secondsString).\(tm.millisecondsString)")
                                .font(.system(size: 54, weight: .bold, design: .rounded))
                                .minimumScaleFactor(0.8)
                        }
                        .onAppear{ tm.start() }
                        .onDisappear{ tm.stop() }
                }
                
                Spacer()
                
                VStack {
                    Button(role: .destructive) {
                        rm.stop()
                        tm.stop()
                        showDecorateTicketView = true
                        
                        let newRecord = Record(context: viewContext)
                        newRecord.id = UUID()
                        newRecord.url = rm.recordURL
                        newRecord.ticket?.colorName = TicketColor.mint.name
                        save()
                        
                    } label: {
                        Text("완료")
                            .font(.headline)
                    }
                    .buttonStyle(ModalBottomButtonStyle())
//                    .fullScreenCover(isPresented: $showDecorateTicketView) {
//                        DecorateTicketView()
//                    }
                    
                    Button(role: .cancel) {
                        showDialog = true
                    } label: {
                        Text("취소")
                    }
                    .buttonStyle(ModalBottomButtonStyle())
                    .confirmationDialog("정말로 녹음을 취소하시겠어요?", isPresented: $showDialog, titleVisibility: .visible) {
                        Button("네", role: .destructive) {
                            rm.stop()
                            dismiss()
                        }
                        
                        Button("아니요", role: .cancel) {
                            showDialog = false
                        }
                    }
                }
                .padding(.bottom, 10)
            }
            .navigationBarHidden(true)
            .background(
                NavigationLink(isActive: $showDecorateTicketView, destination: {
                    DecorateTicketView() {
                        dismiss()
                    }
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                }, label: {
                    EmptyView()
                })
            )
            .onAppear {
                rm.start()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    ani = true
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private var recordCircle: some View {
        ZStack {
            Circle()
                .fill(.red.opacity(ani ? 0.08 : 0.04))
                .animation(.easeInOut(duration: 0.6).delay(0.4).repeatForever(), value: ani)
                .padding(ani ? 0 : 12)
            
            Circle()
                .fill(.red.opacity(ani ? 0.1 : 0.05))
                .animation(.easeInOut(duration: 0.8).delay(0.2).repeatForever(), value: ani)
                .padding(ani ? 18 : 24)
            
            Circle()
                .fill(.red.opacity(ani ? 0.12 : 0.06))
                .animation(.easeInOut(duration: 1).repeatForever(), value: ani)
                .padding(36)
            
            VStack(spacing: 8) {
                Image(systemName: "waveform")
                    .font(.system(size: 42, weight: .bold))
                Text("녹음 중..")
                    .scaledFont(name: CustomFont.gothicNeoExBold, size: 17)
                    .offset(x: 4)
            }
            .foregroundColor(.red)
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

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
