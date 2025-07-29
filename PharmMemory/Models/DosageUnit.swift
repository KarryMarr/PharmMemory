//
//  DosageUnit.swift
//  PharmMemory
//
//  Created by Karina Blinova on 15.07.2025.
//

enum DosageUnit: String, CaseIterable {
    case milligrams = "мг"
    case percent = "%"
    case grams = "г"
    
    var title: String {
        return self.rawValue
    }
}
