//
//  Line.swift
//  RecordTicket
//
//  Created by 김예훈 on 2022/04/26.
//

import SwiftUI


struct VLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        return path
    }
}

struct HLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

struct Line_Previews: PreviewProvider {
    static var previews: some View {
        VLine()
          .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
          .frame(height: 1)
    }
}
