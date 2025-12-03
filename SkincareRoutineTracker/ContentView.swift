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
            RoutinePageView()
                .tabItem {
                    Label("Routine", systemImage: "list.bullet.rectangle")
                }
            SkinConcernsPageView()
                .tabItem {
                    Label("Skin Concerns", systemImage: "heart.text.square")
                }
            AllProductsView()
                .tabItem {
                    Label("View All", systemImage: "shippingbox")
                }
//            ProductDetailPageView()
//                .tabItem {
//                    Label("About Products", systemImage: "5.circle")
//                } // eventually move this, take user to this view when a product is clicked
        }
    }
}

#Preview {
    ContentView()
}
