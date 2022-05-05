//
//  Modifier.swift
//  RecordTicket
//
//  Created by 김예훈 on 2022/05/05.
//

import SwiftUI

struct FlipModifier<OutSideContent: View>: AnimatableModifier {
    
    var progress: Double
    var outsideContent: OutSideContent
    
    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }
    
    init(progress: Double, @ViewBuilder outsideContent: @escaping () -> OutSideContent) {
        self.progress = progress
        self.outsideContent = outsideContent()
    }
    
    func body(content: Content) -> some View {
        ZStack {
            if progress >= 0.5 {
                content
                    .rotation3DEffect(
                        .degrees(-180),
                        axis: (x: 1.0, y: 0.0, z: 0.0),
                        anchor: .center,
                        anchorZ: 0.0,
                        perspective: 0.5)
            } else {
                outsideContent
            }
        }
        .rotation3DEffect(
            .degrees(progress * -180),
            axis: (x: 1.0, y: 0.0, z: 0.0),
            anchor: .center,
            anchorZ: 0.0,
            perspective: 0.5)
    }
}
