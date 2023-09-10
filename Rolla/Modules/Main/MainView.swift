//
//  MainView.swift
//  Rolla
//
//  Created by Faris Hurić on 10. 9. 2023..
//

import SwiftUI

struct MainView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor(.purple)
    }
    var body: some View {
        TabView {
            ScanView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .toolbarBackground(Color.yellow, for: .tabBar)
                .toolbar(.visible, for: .tabBar)

            TrackView()
                .tabItem {
                    Image(systemName: "tray")
                    Text("Profile")
                }

            FilterView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Settings")
                }
        }
        .tint(.white)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}