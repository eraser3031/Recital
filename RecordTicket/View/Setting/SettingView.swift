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
            .customSheet(title: "Interface and Theme", isPresented: $showColorScheme) {
                ColorThemeSettingSheetView(colorScheme: $colorScheme)
            }
        }
        .navigationViewStyle(.stack)
        .accentColor(.primary)
    }

    private var themeSection: some View {
        SettingSection(title: "Interface and Theme") {
            Button {
                withAnimation(.spring()) {
                    showColorScheme = true
                }
            } label: {
                HStack {
                    Text("Appearance")
                        .foregroundColor(.primary)
                    Spacer()
                    Text(colorScheme == nil ? "System" : (colorScheme ?? false) ? "Dark" : "Light")
                }
            }
            .padding(12)
        }
    }

    private var personalDataSection: some View {
        SettingSection(title: "Personal") {
            NavigationLink {
                ImageManageSettingView()
            } label: {
                HStack {
                    Text("Delete Picture Data")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
            }
            .padding(12)

            Divider().padding(.leading)

            NavigationLink {
                DataManageSettingView()
            } label: {
                HStack {
                    Text("Delete All Data")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
            }
            .padding(12)
        }
    }

    private var appInfoSection: some View {
        SettingSection(title: "App") {
            Button {
                guard let url = URL(string: UIApplication.openSettingsURLString)
                else { return }

                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            } label: {
                HStack {
                    Text("Permissions")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
            }
            .padding(12)
            
            Divider().padding(.leading)
            
            NavigationLink {
                InfoSettingView()
            } label: {
                HStack {
                    Text("Info")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
            }
            .padding(12)
        }

    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(colorScheme: .constant(nil))
    }
}
