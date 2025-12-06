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
            .tabItem {
                Label("Home", systemImage: "house")
            }
            SkinConcernsPageView()
                .tabItem {
                    Label("Skin Concerns", systemImage: "heart.text.square")
                }
            AllProductsView()
                .tabItem {
                    Label("View All", systemImage: "shippingbox")
                }
        }
    }
}

#Preview {
    ContentView()
}
