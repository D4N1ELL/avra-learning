//
//  ContentView.swift
//  Avra
//
//  Created by Daniel Istrati on 16.10.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .house
    @State private var isTabBarVisible: Bool = true

    var body: some View {
        NavigationStack {
            ZStack {
                TabView(selection: $selectedTab) {
                    LibraryView()
                        .tag(Tab.house)
                    
                    ProgressView()
                        .tag(Tab.chart)
                    
                    MessageView()
                        .tag(Tab.message)
                    
                    ProfileView()
                        .tag(Tab.person)
                }
                
                VStack {
                    Spacer()
                        CustomTabBar(isTabBarVisible: $isTabBarVisible, selectedTab: $selectedTab)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
