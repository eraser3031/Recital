//
//  PlayerView.swift
//  RecordTicket
//
//  Created by 김예훈 on 2022/04/28.
//

import SwiftUI

struct PlayerView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var am = AudioManager()
    
    var record: Record
    @State private var value: Double = 0.0
    @State private var isEditing = false
    
    @State private var ticketColor = TicketColor.pink
    @State private var image = Image("TestImage")
    
    let timer = Timer
        .publish(every: 0.1, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        ZStack(alignment: .top) {
            ticketColor.color
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Rectangle()
                    .overlay(
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    )
                    .cornerRadius(1000, corners: [.bottomLeft, .bottomRight])
                    .padding(.bottom)
                    
                
                VStack(spacing: 24) {
//                    HLine()
//                        .stroke(TicketColor.pink.color, lineWidth: 80)
//                        .frame(height: 80)
                    
                    Slider(value: $value, in: 0...(am.player?.duration ?? 0)) { editing in
                        isEditing = editing
                        if !editing {
                            am.player?.currentTime = value
                        }
                    }
                    .tint(.white)
                    .animation(.linear, value: value)
                    
                    Text("-03:23")
                        .font(.subheadline.bold())
                        .foregroundColor(Color(.systemBackground))
                    
                    HStack(spacing: 60) {
                        Button {
                            am.player?.currentTime -= 15
                        } label: {
                            Image(systemName: "gobackward.15")
                                .font(.title.weight(.semibold))
                        }
                        .buttonStyle(playerButtonStyle())
                        
                        Button {
                            am.playPause()
                        } label: {
                            Image(systemName: (am.player?.isPlaying ?? false) ? "pause.fill" : "play.fill")
                                .font(.system(size: 46, weight: .bold, design: .default))
                        }
                        .buttonStyle(playerButtonStyle())
                        
                        Button {
                            am.player?.currentTime += 15
                        } label: {
                            Image(systemName: "goforward.15")
                                .font(.title.weight(.semibold))
                        }
                        .buttonStyle(playerButtonStyle())
                    }
                    .foregroundColor(Color(.systemBackground))
                }
                .padding(.bottom, 20)
            }
            .ignoresSafeArea(.all, edges: .top)
            
            VStack {
                HStack {
                    Button(role: .cancel) {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                    }
                    .buttonStyle(FloatButtonStyle())
                    
                    Spacer()
                    
                    Button(role: .destructive) {
                        dismiss()
                    } label: {
                        Image(systemName: "pencil")
                            .font(.headline)
                    }
                    .buttonStyle(FloatButtonStyle())
                    
                }
                .padding(.horizontal, 20)
                Spacer()
            }
        }
        .onAppear{
            am.startPlayer(url: record.url!)
        }
        .onReceive(timer) { _ in
            guard let player = am.player, !isEditing else { return }
            value = player.currentTime
        }
    }
}

//struct PlayerView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayerView()
//    }
//}

struct playerButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

struct FloatButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .fill(.thinMaterial)
                .frame(width: 44, height: 44)
            
            configuration.label
        }
    }
}
