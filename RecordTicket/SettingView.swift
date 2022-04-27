//
//  SettingView.swift
//  RecordTicket
//
//  Created by 김예훈 on 2022/04/27.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 28) {
                Text("Setting")
                    .scaledFont(name: CustomFont.gilroyExtraBold, size: 28)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top, 40)
                
                themeSection
                    .padding(.horizontal, 20)
                
                personalDataSection
                    .padding(.horizontal, 20)
                
                appInfoSection                .padding(.horizontal, 20)
                
                
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
    
    private var themeSection: some View {
        CustomSection(title: "테마") {
            NavigationLink {
                Text("hi")
            } label: {
                HStack {
                    Text("화면 테마")
                        .foregroundColor(.primary)
                    Spacer()
                    Text("시스템 설정")
                    Image(systemName: "chevron.right")
                }
            }
            .padding(12)
        }
    }
    
    private var personalDataSection: some View {
        CustomSection(title: "개인정보") {
            NavigationLink {
                Text("hi")
            } label: {
                HStack {
                    Text("사진 데이터 삭제")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
            }
            .padding(12)
            
            Divider()
                .padding(.leading)
            
            NavigationLink {
                Text("hi")
            } label: {
                HStack {
                    Text("전체 데이터 삭제")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
            }
            .padding(12)
        }
    }
    
    private var appInfoSection: some View {
        CustomSection(title: "앱") {
            NavigationLink {
                Text("hi")
            } label: {
                HStack {
                    Text("권한 설정")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
            }
            .padding(12)
            
            Divider()
                .padding(.leading)
            
            NavigationLink {
                Text("hi")
            } label: {
                HStack {
                    Text("앱 정보")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
            }
            .padding(12)
        }
        
    }
}

struct CustomSection<Content: View>: View {
    
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

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
