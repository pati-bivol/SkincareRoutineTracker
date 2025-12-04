//
//  HomePageView.swift
//  SkincareRoutineTracker
//
//  Created by Pati Bivol on 12/1/25.
//

import SwiftUI

struct HomePageView: View {
    @State private var morningCompleted = 2
    @State private var morningTotal = 4
    
    @State private var nightCompleted = 1
    @State private var nightTotal = 3
    
    var todayString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full   // e.g. "Wednesday, December 3, 2025"
        return formatter.string(from: Date())
    }
    
    var morningProgress: Double {
        if morningTotal == 0 { return 0 }
        return Double(morningCompleted) / Double(morningTotal)
    }
    
    var nightProgress: Double {
        if nightTotal == 0 { return 0 }
        return Double(nightCompleted) / Double(nightTotal)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // Today’s date
                    Text(todayString)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    // Morning section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Morning Routine")
                            .font(.headline)
                        
                        ProgressView(value: morningProgress)
                            .tint(.blue)
                        
                        Text("\(morningCompleted) of \(morningTotal) steps completed")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        NavigationLink(destination: RoutinePageView()) {
                            Text("Go to Morning Routine")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
                    
                    // Night section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Night Routine")
                            .font(.headline)
                        
                        ProgressView(value: nightProgress)
                            .tint(.purple)
                        
                        Text("\(nightCompleted) of \(nightTotal) steps completed")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        NavigationLink(destination: RoutinePageView()) {
                            Text("Go to Night Routine")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.purple)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Today")
        }
    }
}

#Preview {
    HomePageView()
}
