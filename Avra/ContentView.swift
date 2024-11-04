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
    
    init() {
            UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
            ZStack {
                VStack {
                    TabView(selection: $selectedTab) {
                        LibraryView(isTabBarVisible: $isTabBarVisible)
                            .tag(Tab.house) // Assign tag for tab selection
                                        
                        ProgressView()
                            .tag(Tab.chart)
                                            
                        MessageView()
                            .tag(Tab.message)
                                            
                        ProfileView()
                            .tag(Tab.person)
                    }
                }
                
                if isTabBarVisible {
                    VStack {
                        Spacer()
                        CustomTabBar(isTabBarVisible: $isTabBarVisible, selectedTab: $selectedTab) // Pass isTabBarVisible to control visibility
                        }
                }
                
                VStack {
                    Spacer()
                    CustomTabBar(isTabBarVisible: $isTabBarVisible, selectedTab: $selectedTab)
                }
            }
        }
    
}

struct ContentView_Previews: PreviewProvider {
static var previews: some View {
        ContentView()
    }
}
