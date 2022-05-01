//
//  Font.swift
//  RecordTicket
//
//  Created by 김예훈 on 2022/04/26.
//

import SwiftUI

struct CustomFont {
    static let gothicNeoHeavy = "AppleSDGothicNeo-Heavy"
    static let gothicNeoExBold = "AppleSDGothicNeo-ExtraBold"
    static let spoqaRegular = "SpoqaHanSansNeo-Regular"
    static let spoqaBold = "SpoqaHanSansNeo-Bold"
    static let gilroyExtraBold = "Gilroy-ExtraBold"
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var name: String
    var size: CGFloat

    func body(content: Content) -> some View {
       let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.custom(name, size: scaledSize))
    }
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
extension View {
    func scaledFont(name: String, size: CGFloat) -> some View {
        return self.modifier(ScaledFont(name: name, size: size))
    }
}
