//
//  CustomPlayerSlider.swift
//  RecordTicket
//
//  Created by 김예훈 on 2022/05/04.
//

import SwiftUI

struct CustomPlayerSlider<T>: View where T: BinaryFloatingPoint, T.Stride : BinaryFloatingPoint {
    
    @Binding var value: T
    var bounds: ClosedRange<T>
    let color: Color
    let onEditingChanged: (Bool) -> Void
    
    init(value: Binding<T>, in bounds: ClosedRange<T> = 0...1, color: Color, onEditingChanged: @escaping (Bool) -> Void = { _ in}) {
        self._value = value
        self.bounds = bounds
        self.color = color
        self.onEditingChanged = onEditingChanged
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .trailing) {
                HStack(spacing: 3) {
                    ForEach(0..<Int(geo.size.width / 5), id: \.self) { _ in
                        Rectangle()
                            .fill(.white.opacity(0.8))
                            .frame(width: 2)
                            .padding(.vertical, 4)
                    }
                }
                
                Rectangle()
                    .fill(LinearGradient(colors: [color.opacity(0.7), color.opacity(0.9)], startPoint: .leading, endPoint: .trailing))
                    .frame(width: geo.size.width - geo.size.width * (CGFloat(value / bounds.upperBound).isNaN ? 0.01 : CGFloat(value / bounds.upperBound)) )
                    .padding(.vertical, 4)
                
                ZStack {
                    Capsule()
                        .frame(width: 6)
                        .foregroundColor(Color(.systemBackground))
                        .offset(x: geo.size.width * (CGFloat(value / bounds.upperBound).isNaN ? 0.01 : CGFloat(value / bounds.upperBound)) )
                        .shadow(color: .black.opacity(0.2), radius: 40, x: 0, y: 0)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .gesture(
                DragGesture()
                    .onChanged{ transition in
                        onEditingChanged(true)
                        value = T(CGFloat(transition.location.x / geo.size.width) * CGFloat(bounds.upperBound))
                    }
                
                    .onEnded{ _ in
                        onEditingChanged(false)
                    }
            )
        }
    }
}

//struct CustomPlayerSlider_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomPlayerSlider()
//    }
//}
