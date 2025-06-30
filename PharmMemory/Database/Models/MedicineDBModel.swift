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
    @Attribute(.unique) var id: UUID
    var title: String
    var dose: String
    var count: String
    var notes: String?
    var barcode: String?
    var expiryDate: Date
    
    init(
        id: UUID,
        title: String,
        dose: String,
        count: String,
        notes: String? = nil,
        barcode: String?,
        expiryDate: Date
    ) {
        self.id = id
        self.title = title
        self.dose = dose
        self.count = count
        self.notes = notes
        self.barcode = barcode
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
            barcode: medicine.barcode,
            expiryDate: medicine.expiryDate)
    }
}

extension Medicine {
    init(from dbModel: MedicineDBModel) {
        self.init(
            id: dbModel.id,
            title: dbModel.title,
            dose: dbModel.dose,
            count: dbModel.count,
            notes: dbModel.notes ?? String.empty,
            barcode: dbModel.barcode,
            expiryDate: dbModel.expiryDate)
    }
}
