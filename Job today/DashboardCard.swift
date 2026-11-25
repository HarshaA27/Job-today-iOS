//
//  DashboardCard.swift
//  Job today
//
//  Created by Test on 25/11/26.
//
import SwiftUI


struct DashboardCard: View {
    
    let title: String
    let value: Int
    let color: Color
    
    
    var body: some View {
        
        VStack(spacing: 8) {
            
            Text("\(value)")
                .font(.title)
                .bold()
            
            Text(title)
                .font(.caption)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(color.opacity(0.15))
        .cornerRadius(15)
    }
}
