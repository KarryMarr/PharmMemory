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
    var dosageUnits: String
    var count: String?
    var notes: String?
    var barcode: String?
    var expiryDate: Date
    var isOnShoppingList: Bool
    
    init(
        id: UUID,
        title: String,
        dose: String,
        dosageUnits: DosageUnits,
        count: String?,
        notes: String? = nil,
        barcode: String?,
        expiryDate: Date,
        isOnShoppingList: Bool
    ) {
        self.id = id
        self.title = title
        self.dose = dose
        self.dosageUnits = dosageUnits.rawValue
        self.count = count
        self.notes = notes
        self.barcode = barcode
        self.expiryDate = expiryDate
        self.isOnShoppingList = isOnShoppingList
    }
}

extension MedicineDBModel {
    convenience init(from medicine: Medicine) {
        self.init(
            id: medicine.id,
            title: medicine.title,
            dose: medicine.dose,
            dosageUnits: medicine.dosageUnits,
            count: medicine.count,
            notes: medicine.notes,
            barcode: medicine.barcode,
            expiryDate: medicine.expiryDate,
            isOnShoppingList: medicine.isOnShoppingList)
    }
}

extension Medicine {
    init(from dbModel: MedicineDBModel) {
        self.init(
            id: dbModel.id,
            title: dbModel.title,
            dose: dbModel.dose,
            dosageUnits: DosageUnits(rawValue: dbModel.dosageUnits) ?? .milligrams,
            count: dbModel.count ?? "",
            notes: dbModel.notes ?? String.empty,
            barcode: dbModel.barcode,
            expiryDate: dbModel.expiryDate,
            isOnShoppingList: dbModel.isOnShoppingList)
    }
}
