//
//  MainScreen.swift
//  SelfStudy
//
//  Created by simon on 30/08/2025.
//

import SwiftUI

struct MainScreen: View {
    
    init() {
        // Unselected tab color + background
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    var body: some View {
        TabView {
            Dashboard()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Dashboard")
                }
            
            Analytic().tabItem {
                Image("ic-analytic")
                    .resizable()
                    .scaledToFit()
                Text("Analytic")
            }
            Room().tabItem {
                Image("ic-room")
                    .resizable()
                    .scaledToFit()
                Text("Room")
            }
            
            Setting().tabItem {
                Image(systemName: "house.fill")
                Text("Setting")
            }
        }.tint(.black)
    }
}

// ✅ Previews (for Xcode canvas only)
struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
