//
//  EdgeRectangle.swift
//  RecordTicket
//
//  Created by 김예훈 on 2022/04/28.
//

import SwiftUI

struct EdgeRectangle: Shape {
    
    var cornerRadius: CGFloat = 12
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.move(to: CGPoint(x: cornerRadius, y: 0))
        path.addLine(to: CGPoint(x: rect.width - cornerRadius, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: cornerRadius))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height - cornerRadius))
        path.addLine(to: CGPoint(x: rect.width - cornerRadius, y: rect.height))
        path.addLine(to: CGPoint(x: cornerRadius, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height - cornerRadius))
        path.addLine(to: CGPoint(x: 0, y: cornerRadius))
        path.addLine(to: CGPoint(x: cornerRadius, y: 0))
        return path
    }
}

struct EdgeRectangle_Previews: PreviewProvider {
    static var previews: some View {
        EdgeRectangle(cornerRadius: 9)
            .fill(Color(hex: 0xf7b0be))
            .frame(width: 270, height: 140)
    }
}
