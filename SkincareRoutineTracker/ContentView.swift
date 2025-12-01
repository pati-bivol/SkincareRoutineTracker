//
//  ContentView.swift
//  SkincareRoutineTracker
//
//  Created by Pati Bivol on 11/30/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomePageView()
            .tabItem{
                Label("Home", systemImage: "1.circle")
            }
            RoutinePageView()
                .tabItem{
                    Label("Routine", systemImage: "2.circle")
                }
            SkinConcernsPageView()
                .tabItem{
                    Label("Skin Concerns", systemImage: "3.circle")
                }
            ProductDetailPageView()
                .tabItem{
                    Label("About Products", systemImage: "4.circle")
                }
        }
    }
}

#Preview {
    ContentView()
}
