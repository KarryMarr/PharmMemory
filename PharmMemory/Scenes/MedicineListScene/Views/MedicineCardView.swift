//
//  MedicineCardView.swift
//  PharmMemory
//
//  Created by Karina Blinova on 22.06.2025.
//
import SwiftUI

private extension CGFloat {
    static let stackSpacing: CGFloat = 8
    static let circleWidthHeight: CGFloat = 12
    static let padding: CGFloat = 12
    static let cornerRadius: CGFloat = 10
}

struct MedicineCardView: View {
    let medicine: Medicine
    
    var body: some View {
        VStack(alignment: .leading, spacing: CGFloat.stackSpacing) {
            HStack {
                Text(medicine.title)
                    .font(Font.bodyBold)
                    .foregroundColor(Color.textPrimary)
                
                Spacer()
                
                Circle()
                    .fill(medicine.expiryStatus.statusColor)
                    .frame(width: CGFloat.circleWidthHeight, height: CGFloat.circleWidthHeight)
            }
            
            Text(medicine.dose)
                .font(Font.bodyText)
                .foregroundColor(Color.textSecondary)
            
            HStack {
                Text("\(medicine.count) шт.")
                    .font(Font.captionText)
                
                Spacer()
                
                Text("Годен до \(medicine.expiryDate.formatted(date: .numeric, time: .omitted))")
                    .font(.captionText)
            }
            .foregroundColor(Color.textSecondary)
        }
        .padding(CGFloat.padding)
        .cornerRadius(CGFloat.cornerRadius)
    }
}
