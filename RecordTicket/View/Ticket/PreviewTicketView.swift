//
//  PreviewTicketView.swift
//  RecordTicket
//
//  Created by 김예훈 on 2022/05/03.
//

import SwiftUI

struct PreviewTicketView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var title: String
    @Binding var color: TicketColor
    @Binding var image: [UIImage]
    @Binding var shape: TicketShape
    
    var date: Date
    var location: String
    var length: String
    
    var body: some View {
        HStack(spacing: 0){
            mainPart
            subPart
        }
        .aspectRatio(2.5, contentMode: .fit)
        .overlay(
            Image("NoiseTexture")
                .opacity(0.12)
                .blendMode(colorScheme == .light ? .lighten : .overlay)
        )
    }
    
    private var mainPart: some View {
        VStack(alignment: .leading) {
            Text(title)
                .scaledFont(name: CustomFont.gothicNeoHeavy, size: 17)
                .lineLimit(1)
            
            Spacer()
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text(date, format: Date.FormatStyle(date: .long, time: .omitted) )
                    Text(date, format: Date.FormatStyle(date: .omitted, time: .shortened) )
                }
                     
                Spacer()
                
                Text(location)
            }
            .font(.subheadline)
        }
        .padding()
        .background(
            shape
                .makeShape(color: color.color)
        )
    }
    
    private var subPart: some View {
        Text(length)
            .fontWeight(.heavy)
            .rotationEffect(Angle(degrees: -90))
            .padding()
            .frame(maxHeight: .infinity)
            .background(
                shape
                    .makeShape(color: color.color)
            )
            .overlay(
                VLine()
                    .stroke(Color(.systemGray6), style: .init(lineWidth: 2, dash: [8, 8]))
                    .frame(width: 2)
                    .padding(.vertical, 8)
                ,alignment: .leading
            )

    }
}

//struct PreviewTicketView_Previews: PreviewProvider {
//    static var previews: some View {
//        PreviewTicketView()
//    }
//}
