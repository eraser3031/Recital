//
//  ContentView.swift
//  RecordTicket
//
//  Created by 김예훈 on 2022/04/25.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("colorScheme") var colorScheme: Bool?
    @State private var tabSelection: TabBarItem = .tickets
    @State private var showRecordView = false
    
    var body: some View {
        CustomTabBarContainerView(selection: $tabSelection, action: {showRecordView = true}) {
            TicketListView(showRecordView: $showRecordView)
                .tabBarItem(tab: .tickets, selection: $tabSelection)
            
            SettingView(colorScheme: $colorScheme)
                .tabBarItem(tab: .settings, selection: $tabSelection)
        }
        .preferredColorScheme(colorScheme == nil ? nil : (colorScheme ?? false) == true ? .dark : .light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
