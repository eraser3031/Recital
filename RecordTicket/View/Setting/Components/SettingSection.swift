//
//  SettingSection.swift
//  RecordTicket
//
//  Created by 김예훈 on 2/28/25.
//

import SwiftUI


struct SettingSection<Content: View>: View {
    var title: LocalizedStringKey
    let content: () -> Content

    init(title: LocalizedStringKey, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }

    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .scaledFont(name: CustomFont.gothicNeoExBold, size: 15)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray6))

            VStack(spacing: 0) {
                content()
            }
        }
        .tint(.primary)
    }
}
