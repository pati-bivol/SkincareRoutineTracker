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
            
            RoutinePageView()
            
            EditScreenView()
            
            SkinConcernsPageView()
            
            ProductDetailPageView()
        }
    }
}

#Preview {
    ContentView()
}
