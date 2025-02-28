//
//  ColorThemeSettingSheetView.swift
//  RecordTicket
//
//  Created by 김예훈 on 2/28/25.
//

import SwiftUI

fileprivate enum ColorThemeItem: String, Identifiable, CaseIterable {
    case system, light, dark
    
    var id: String { self.rawValue }
    
    var name: LocalizedStringKey {
        switch self {
        case .system: return "System"
        case .light: return "Light Mode"
        case .dark: return " Dark Mode"
        }
    }
    
    var imageName: String {
        switch self {
        case .system: return "System"
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }
}

struct ColorThemeSettingSheetView: View {
    @Binding var colorScheme: Bool?
    
    var body: some View {
        HStack(spacing: 24) {
            ForEach(ColorThemeItem.allCases) { item in
                Button {
                    switch item {
                    case .system: colorScheme = nil
                    case .light: colorScheme = false
                    case .dark: colorScheme = true
                    }
                } label: {
                    VStack {
                        Image(item.imageName)
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                        Text(item.name)
                            .font(.footnote.weight(.semibold))
                            .padding(.bottom, 8)
                        Image(systemName: isSelected(item) ? "checkmark.circle.fill" : "circle")
                        .font(.title2.weight(.semibold))
                    }
                    .padding(.vertical)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Theme")
    }
    
    private func isSelected(_ item: ColorThemeItem) -> Bool {
        switch item {
        case .system: return colorScheme == nil
        case .light: return colorScheme == false
        case .dark: return colorScheme == true
        }
    }
}
#Preview {
    ColorThemeSettingSheetView(colorScheme: .constant(false))
}
