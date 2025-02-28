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

    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack(alignment: .top) {
            background
            VStack(spacing: 20) {
                ticketImageView
                playerControlView
            }
            .ignoresSafeArea(.all, edges: .top)
            navigationBar
        }
        .onAppear {
            guard
                let imageName = record.ticket?.imageName,
                let fileName = record.fileName
            else { return }
            let image = ImageManager.instance.getImage(named: imageName)
            
            am.startPlayer(fileName: fileName, title: record.title ?? "Untitled", image: image)
        }
        .onReceive(timer) { _ in
            guard let player = am.player, !isEditing else { return }
            value = player.currentTime
        }
    }
    
    private var background: some View {
        record.ticket?.color
            .ignoresSafeArea()
    }
    
    private var ticketImageView: some View {
        Rectangle()
            .overlay(
                ZStack {
                    if let imageName = record.ticket?.imageName {
                        Image(uiImage: ImageManager.instance.getImage(named: imageName))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                    Color.black.opacity(0.1)
                }
            )
            .cornerRadius(1000, corners: [.bottomLeft, .bottomRight])
            .padding(.bottom)
            .overlay(alignment: .bottom) {
                VStack {
                    Text(record.title ?? "")
                        .scaledFont(name: CustomFont.gothicNeoHeavy, size: 22)
                    Text(record.date ?? Date(), format: Date.FormatStyle(date: .long, time: .omitted))
                        .font(.subheadline.weight(.semibold))
                }
                .foregroundColor(.white)
                .padding(.bottom, 100)
            }
    }
    
    private var playerControlView: some View {
        VStack(spacing: 24) {
            VStack(spacing: 8) {
                HStack {
                    Text(DateComponentsFormatter.positional.string(from: am.player?.currentTime ?? 0) ?? "0:00")
                    Spacer()
                    Text(DateComponentsFormatter.positional.string(from: am.player?.duration ?? 0) ?? "0:00")
                }
                .font(.caption.monospacedDigit())
                .foregroundColor(Color(.systemBackground))
                .padding(.horizontal, 20)

                CustomPlayerSlider(
                    value: $value, in: 0...(am.player?.duration ?? 0),
                    color: record.ticket?.color ?? .black
                ) { editing in
                    isEditing = editing
                    if !editing {
                        am.player?.currentTime = value
                    }
                }
                .frame(height: 50 + 8)
                .tint(.white)
                .padding(.horizontal, 20)
                .animation(.timingCurve(0.25, 1, 0.5, 1), value: value)
            }
            .padding(.bottom, 10)

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
                    Image(systemName: (am.player?.isPlaying ?? false) ? "pause.circle.fill" : "play.circle.fill")
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
        .padding(.bottom, 32)
    }
    
    private var navigationBar: some View {
        HStack {
            Button(role: .cancel) {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.headline)
            }
            .buttonStyle(FloatButtonStyle())

            Spacer()


        }
        .padding(.horizontal, 20)
    }
}

fileprivate struct playerButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

fileprivate struct FloatButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .fill(.thinMaterial)
                .frame(width: 44, height: 44)

            configuration.label
        }
    }
}
