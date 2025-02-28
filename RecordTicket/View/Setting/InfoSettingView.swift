//
//  InfoSettingView.swift
//  RecordTicket
//
//  Created by 김예훈 on 2/28/25.
//

import SwiftUI

struct InfoSettingView: View {
    var body: some View {
        VStack(spacing: 24) {
            Image("Icon")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 24, style: .continuous))
            Text("Re cital")
                .font(.title.bold())
            Text("1.0.0")
            Text("Made by eraiser")
                .foregroundColor(Color(.systemGray5))
        }
    }
}

#Preview {
    InfoSettingView()
}
