//
//  DataManageSettingView.swift
//  RecordTicket
//
//  Created by 김예훈 on 2/28/25.
//

import SwiftUI

struct DataManageSettingView: View {
    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 20) {
                Image(systemName: "exclamationmark.circle.fill")
                    .font(.system(size: 60))
                Text("All recordings, photos, and all data will be permanently deleted and cannot be undone. Are you sure you want to proceed?")
                .multilineTextAlignment(.center)
                .font(.title3)
                .frame(width: 240)
            }

            Button(role: .destructive) {
                // TODO: 실 데이터 삭제 로직 추가하기
            } label: {
                Text("Delete")
                    .font(.headline)
                    .padding(.vertical, 8)
                    .frame(maxWidth: 300)
            }
            .tint(.red)
            .buttonStyle(.bordered)
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    DataManageSettingView()
}
