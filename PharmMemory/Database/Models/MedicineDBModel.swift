//
//  MedicineDBModel.swift
//  PharmMemory
//
//  Created by Karina Blinova on 19.06.2025.
//
import Foundation
import SwiftData

@Model
final class MedicineDBModel {
    var id: Int
    var title: String
    var dose: String
    var count: String
    var notes: String?
    var expiryDate: Date
    
    init(
        id: Int,
        title: String,
        dose: String,
        count: String,
        notes: String? = nil,
        expiryDate: Date
    ) {
        self.id = id
        self.title = title
        self.dose = dose
        self.count = count
        self.notes = notes
        self.expiryDate = expiryDate
    }
}

extension MedicineDBModel {
    convenience init(from medicine: Medicine) {
        self.init(
            id: medicine.id,
            title: medicine.title,
            dose: medicine.dose,
            count: medicine.count,
            notes: medicine.notes,
            expiryDate: medicine.expiryDate)
    }
}
