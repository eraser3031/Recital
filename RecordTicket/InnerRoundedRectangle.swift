//
//  InnerRoundedRectangle.swift
//  RecordTicket
//
//  Created by 김예훈 on 2022/04/26.
//

import SwiftUI

struct InnerRoundedRectangle: Shape {
    
    var cornerRadius: CGFloat = 12
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.move(to: CGPoint(x: cornerRadius, y: 0))
        path.addLine(to: CGPoint(x: rect.width - cornerRadius, y: 0))
        path.move(to: CGPoint(x: rect.width - cornerRadius, y: 0))
        path.addQuadCurve(to: CGPoint(x: rect.width, y: cornerRadius), control: CGPoint(x: rect.width - cornerRadius, y: cornerRadius))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height - cornerRadius))
        path.addQuadCurve(to: CGPoint(x: rect.width - cornerRadius, y: rect.height), control: CGPoint(x: rect.width - cornerRadius, y: rect.height - cornerRadius))
        path.addLine(to: CGPoint(x: cornerRadius, y: rect.height))
        path.addQuadCurve(to: CGPoint(x: 0, y: rect.height - cornerRadius), control: CGPoint(x: cornerRadius, y: rect.height - cornerRadius))
        path.addLine(to: CGPoint(x: 0, y: cornerRadius))
        path.addQuadCurve(to: CGPoint(x: cornerRadius, y: 0), control: CGPoint(x: cornerRadius, y: cornerRadius))
        return path
    }
}

struct InnerRoundedRectangle_Previews: PreviewProvider {
    static var previews: some View {
        InnerRoundedRectangle(cornerRadius: 9)
            .fill(Color(hex: 0xf7b0be))
            .frame(width: 270, height: 140)
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
