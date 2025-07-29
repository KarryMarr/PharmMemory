//
//  MedicineCardView.swift
//  PharmMemory
//
//  Created by Karina Blinova on 22.06.2025.
//
import SwiftUI

private extension CGFloat {
    static let stackSpacing: CGFloat = 8
    static let warningIconHeight: CGFloat = 20
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
                if medicine.expiryStatus != .valid {
                    Image(systemName: "clock.badge.exclamationmark")
                        .resizable()
                        .frame(height: CGFloat.warningIconHeight)
                        .scaledToFit()
                        .foregroundStyle(medicine.expiryStatus.statusColor)
                }
            }
            
            Text("\(medicine.dose) \(medicine.dosageUnits.title)")
                .font(Font.bodyText)
                .foregroundColor(Color.textSecondary)
            
            HStack {
                if !medicine.count.isEmpty {
                    Text("\(medicine.count) шт.")
                        .font(Font.captionText)
                }
                Spacer()
                Text("Годен до \(medicine.expiryDate.formatted(date: .numeric, time: .omitted))")
                    .font(.captionText)
            }
            .foregroundColor(Color.textSecondary)
        }
        .cornerRadius(CGFloat.cornerRadius)
    }
}
