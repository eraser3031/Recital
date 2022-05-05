//
//  SettingView.swift
//  RecordTicket
//
//  Created by 김예훈 on 2022/04/27.
//

import SwiftUI

struct SettingView: View {
    
    @Binding var colorScheme: Bool?
    @State private var showColorScheme = false
    @State private var selected = 1
    
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
                
                appInfoSection
                    .padding(.horizontal, 20)
                
                Spacer()
            }
            .navigationBarHidden(true)
            .customSheet(title: "화면 테마", isPresented: $showColorScheme) {
                ColorSchemeSettingView(colorScheme: $colorScheme)
            }
        }
        .navigationViewStyle(.stack)
        .accentColor(.primary)
    }
    
    private var themeSection: some View {
        CustomSection(title: "테마") {
            Button {
                withAnimation(.spring()) {
                    showColorScheme = true
                }
            } label: {
                HStack {
                    Text("화면 테마")
                        .foregroundColor(.primary)
                    Spacer()
                    Text(colorScheme == nil ? "시스템 설정" : (colorScheme ?? false) ? "다크 모드" : "라이트 모드")
                }
            }
            .padding(12)
        }
    }
    
    private var personalDataSection: some View {
        CustomSection(title: "개인정보") {
            NavigationLink {
                ScrollView {
                    VStack(spacing: 40) {
                        VStack(spacing: 20) {
                            Image(systemName: "exclamationmark.circle.fill")
                                .font(.system(size: 60))
                            
                            Text("정말로 모든 사진 데이터가 삭제되고 취소할 수 없어요. 정말로 삭제하시겠어요?")
                                .multilineTextAlignment(.center)
                                .font(.title3)
                                .frame(width: 240)
                        }
                        
                        Button(role: .destructive) {
                            print("hi")
                        } label: {
                            Text("삭제")
                                .font(.headline)
                                .padding(.vertical, 8)
                                .frame(maxWidth: 300)
                        }
                        .tint(.red)
                        .buttonStyle(.bordered)
                        .padding(.horizontal, 20)
                    }
                }
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
                ScrollView {
                    VStack(spacing: 40) {
                        VStack(spacing: 20) {
                            Image(systemName: "exclamationmark.circle.fill")
                                .font(.system(size: 60))
                            
                            Text("정말로 모든 녹음, 사진을 비롯한 **모든 데이터**가 삭제되고 취소할 수 없어요. 정말로 삭제하시겠어요?")
                                .multilineTextAlignment(.center)
                                .font(.title3)
                                .frame(width: 240)
                        }
                        
                        Button(role: .destructive) {
                            print("hi")
                        } label: {
                            Text("삭제")
                                .font(.headline)
                                .padding(.vertical, 8)
                                .frame(maxWidth: 300)
                        }
                        .tint(.red)
                        .buttonStyle(.bordered)
                        .padding(.horizontal, 20)
                    }
                }
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
            Button {
                guard let url = URL(string: UIApplication.openSettingsURLString) else { return }

                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
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
                VStack(spacing: 24) {
                    VStack {
                        Image("Icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                        
                        Text("Re cital")
                            .font(.title.bold())
                        
                        Text("1.0.0")
                    }
                    
                    
                    VStack {
                        
                        Text("Made by eraiser")
                            .foregroundColor(Color(.systemGray5))
                    }
                    
                    Spacer()
                }
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

struct ColorSchemeSettingView: View {
    
    @Binding var colorScheme: Bool?
    
    var body: some View {
        HStack(spacing: 24) {
            Button {
                colorScheme = nil
            } label: {
                VStack {
                    Image("System")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                    Text("시스템 설정")
                        .font(.footnote.weight(.semibold))
                        .padding(.bottom, 8)
                    Image(systemName: colorScheme == nil ? "checkmark.circle.fill" : "circle")
                        .font(.title2.weight(.semibold))
                }
                .padding(.vertical)
            }
            
            Button {
                colorScheme = false
            } label: {
                VStack {
                    Image("Light")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                    Text("라이트 모드")
                        .font(.footnote.weight(.semibold))
                        .padding(.bottom, 8)
                    Image(systemName: colorScheme == false ? "checkmark.circle.fill" : "circle")
                        .font(.title2.weight(.semibold))
                }
                .padding(.vertical)
            }
            
            Button {
                colorScheme = true
            } label: {
                VStack {
                    Image("Dark")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                    Text("다크 모드")
                        .font(.footnote.weight(.semibold))
                        .padding(.bottom, 8)
                    Image(systemName: colorScheme == true ? "checkmark.circle.fill" : "circle")
                        .font(.title2.weight(.semibold))
                }
                .padding(.vertical)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("화면 테마")
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
//        SettingView(colorScheme: .constant(nil))
        ColorSchemeSettingView(colorScheme: .constant(false))
    }
}
