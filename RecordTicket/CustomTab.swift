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
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content
            CustomTabBarView(tabs: tabs, selection: $selection)
        }
        .onPreferenceChange(TabBarItemsPreferenceKey.self) { value in
            self.tabs = value
        }
    }
}

// Tab View

struct CustomTabBarView: View {
    
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    
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
        .background(Color(.systemBackground))
        .overlay(
            HLine()
                .stroke(Color(.systemGray6))
                .frame(height: 1)
            ,alignment: .top
        )
        .overlay{
            Button {
                print("hi")
            } label: {
                ZStack {
                    Circle()
                        .frame(width: 64, height: 64)
                    
                    Image(systemName: "waveform")
                        .font(.largeTitle)
                        .foregroundColor(Color(.systemBackground))
                }
            }
            .buttonStyle(.plain)
            .offset(y: -32)
        }
    }
    
    func switchToTab(tab: TabBarItem) {
        withAnimation(.easeInOut) {
            selection = tab
        }
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

// Tab Bar Container View

struct CusstomTabBarContainerView<Content: View>: View {
    
    @Binding var selection: TabBarItem
    let content: Content
    @State private var tabs: [TabBarItem] = []
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content
                .edgesIgnoringSafeArea(.all)
            
            CustomTabBarView(tabs: tabs, selection: $selection)
        }
        .onPreferenceChange(TabBarItemsPreferenceKey.self) { value in
            self.tabs = value
        }
    }
     
}
 
