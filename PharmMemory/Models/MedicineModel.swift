//
//  MedicineModel.swift
//  PharmMemory
//
//  Created by Karina Blinova on 18.06.2025.
//
import Foundation
import SwiftUI

private extension Int {
    static let daysInMonth: Int = 30
}

struct Medicine: Identifiable {
    let id: UUID
    var title: String
    var dose: String
    var count: String
    var notes: String
    var barcode: String?
    var expiryDate: Date
    
    var isValid: Bool {
        !title.isEmpty && !dose.isEmpty && !count.isEmpty
    }
    
    var expiryStatus: ExpiryStatus {
        if expiryDate < Date() {
            return .expired
        } else if Calendar.current.dateComponents(
            [.day],
            from: Date(),
            to: expiryDate).day ?? Int.zero <= Int.daysInMonth {
            return .expiring
        } else {
            return .valid
        }
    }
    
    enum ExpiryStatus {
        case valid, expiring, expired
        
        var statusColor: Color {
            switch self {
            case .valid:
                return Color.statusValid
            case .expiring:
                return Color.statusExpiring
            case .expired:
                return Color.statusExpired
            }
        }
    }
}
