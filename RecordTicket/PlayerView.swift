//
//  PlayerView.swift
//  RecordTicket
//
//  Created by 김예훈 on 2022/04/28.
//

import SwiftUI

struct PlayerView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var ticketColor = TicketColor.pink
    @State private var image = Image("TestImage")
    
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
                    HLine()
                        .stroke(TicketColor.pink.color, lineWidth: 80)
                        .frame(height: 80)
                    
                    Text("-03:23")
                        .font(.subheadline.bold())
                        .foregroundColor(Color(.systemBackground))
                    
                    HStack(spacing: 60) {
                        Button {
                            print("back 15")
                        } label: {
                            Image(systemName: "gobackward.15")
                                .font(.title.weight(.semibold))
                        }
                        .buttonStyle(playerButtonStyle())
                        
                        Button {
                            print("play or pause")
                        } label: {
                            Image(systemName: "pause.fill")
                                .font(.system(size: 46, weight: .bold, design: .default))
                        }
                        .buttonStyle(playerButtonStyle())
                        
                        Button {
                            print("go 15")
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
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}

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
