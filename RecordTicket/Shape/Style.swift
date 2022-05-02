//
//  Style.swift
//  RecordTicket
//
//  Created by 김예훈 on 2022/04/27.
//

import SwiftUI

struct TabBarButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

struct ModalBottomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            let isDestructive = configuration.role == .destructive
            
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(isDestructive ? Color.primary : Color(.systemBackground))
                .frame(width: 320, height: 50)
            
            configuration.label
                .foregroundColor(isDestructive ?  Color(.systemBackground) : .gray)
        }
        .opacity(configuration.isPressed ? 0.6 : 1)
        .scaleEffect(configuration.isPressed ? 0.98 : 1)
    }
}
