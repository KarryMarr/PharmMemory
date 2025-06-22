//
//  MedicineCardView.swift
//  PharmMemory
//
//  Created by Karina Blinova on 22.06.2025.
//
import SwiftUI

struct MedicineCardView: View {
    let medicine: Medicine
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(medicine.title)
                    .font(.bodyBold)
                    .foregroundColor(.textPrimary)
                
                Spacer()
                
                Circle()
                    .fill(medicine.statusColor)
                    .frame(width: 12, height: 12)
            }
            
            Text(medicine.dose)
                .font(.bodyText)
                .foregroundColor(.textSecondary)
            
            HStack {
                Text("\(medicine.count) шт.")
                    .font(.captionText)
                
                Spacer()
                
                Text("Годен до \(medicine.expiryDate.formatted(date: .numeric, time: .omitted))")
                    .font(.captionText)
            }
            .foregroundColor(.textSecondary)
        }
        .padding(12)
        .background(Color.cardBackground)
        .cornerRadius(10)
    }
}
