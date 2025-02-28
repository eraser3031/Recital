//
//  CustomTab.swift
//  RecordTicket
//
//  Created by 김예훈 on 2022/04/27.
//

import SwiftUI

// Tab bar Container View

struct CustomTabBarContainerView<Content: View>: View {
    
    @Binding var selection: TabBarItem
    let content: Content
    @State private var tabs: [TabBarItem] = []
    let action: () -> Void
    
    init(selection: Binding<TabBarItem>, action: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.action = action
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            content
        }
        .safeAreaInset(edge: .bottom) {
            CustomTabBarView(tabs: tabs, action: action, selection: $selection)
        }
        .onPreferenceChange(TabBarItemsPreferenceKey.self) { value in
            self.tabs = value
        }
    }
}

// Tab View

struct CustomTabBarView: View {
    
    let tabs: [TabBarItem]
    let action: () -> Void
    @Binding var selection: TabBarItem
    
    init(tabs: [TabBarItem], action: @escaping () -> Void, selection: Binding<TabBarItem>) {
        self.tabs = tabs
        self.action = action
        self._selection = selection
    }
    
    var body: some View {
        tabBarVersion2
    }
}

extension CustomTabBarView {
    func tabView(tab: TabBarItem) -> some View {
        Image(systemName: tab.iconName)
            .symbolVariant( selection == tab ? .fill : .none)
            .font(.headline)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .cornerRadius(10)
            .contentShape(Rectangle())
    }
    
    private var tabBarVersion2: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView(tab: tab)
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
            }
        }
        .padding(10)
        .background(.thinMaterial)
        .overlay(
            HLine()
                .stroke(Color(.systemGray6))
                .frame(height: 1)
            ,alignment: .top
        )
        .overlay{
            if selection == .tickets {
                recordButton
                    .offset(y: -32)
            }
        }
    }
    
    private var recordButton: some View {
        Button {
            action()
        } label: {
            ZStack {
                Circle()
                    .fill(.primary)
                    .frame(width: 64, height: 64)
                
                Image(systemName: "waveform")
                    .font(.largeTitle)
                    .foregroundColor(Color(.systemBackground))
            }
        }
        .buttonStyle(TabBarButtonStyle())
        .animation(.none, value: selection)
    }
    
    func switchToTab(tab: TabBarItem) {
        selection = tab
    }
}

// Tab Bar Item
enum TabBarItem: Hashable {
    case tickets, settings
    
    var title: String {
        switch self {
        case .tickets:
            return "tickets"
        case .settings:
            return "setting"
        }
    }
    
    var iconName: String {
        switch self {
        case .tickets:
            return "rectangle.on.rectangle.angled"
        case .settings:
            return "gearshape"
        }
    }
}

// Tab Bar Preference Key

struct TabBarItemsPreferenceKey: PreferenceKey {
    static var defaultValue: [TabBarItem] = []
    
    static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
        value += nextValue()
    }
}

struct TabBarItemViewModifier: ViewModifier {
    
    let tab: TabBarItem
    @Binding var selection: TabBarItem
    
    func body(content: Content) -> some View {
        content
            .opacity(selection == tab ? 1 : 0)
            .preference(key: TabBarItemsPreferenceKey.self, value: [tab])
    }
}

extension View {
    func tabBarItem(tab: TabBarItem, selection: Binding<TabBarItem>) -> some View {
        modifier(TabBarItemViewModifier(tab: tab, selection: selection))
    }
}
