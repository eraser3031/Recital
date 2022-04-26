//
//  Line.swift
//  RecordTicket
//
//  Created by 김예훈 on 2022/04/26.
//

import SwiftUI


struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        return path
    }
}

struct Line_Previews: PreviewProvider {
    static var previews: some View {
        Line()
          .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
          .frame(height: 1)
    }
}
