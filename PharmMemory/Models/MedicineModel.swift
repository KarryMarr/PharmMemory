//
//  MedicineModel.swift
//  PharmMemory
//
//  Created by Karina Blinova on 18.06.2025.
//
import Foundation
import SwiftUI

struct Medicine: Identifiable {
    let id: UUID
    var title: String
    var dose: String
    var count: String
    var notes: String
    var expiryDate: Date
        
    var expiresSoon: Bool {
        Calendar.current.dateComponents([.day], from: Date(), to: expiryDate).day ?? 0 <= 30
    }
    
    var isExpired: Bool {
        expiryDate < Date()
    }
    
    var statusColor: Color {
        if isExpired {
            return .statusExpired
        } else if expiresSoon {
            return .statusExpiring
        } else {
            return .statusValid
        }
    }
}
