//
//  MedicinesViewModel.swift
//  PharmMemory
//
//  Created by Karina Blinova on 18.06.2025.
//
import SwiftUI

final class MedicinesViewModel: ObservableObject {
    private let databaseService = ServiceLocator.shared.resolve(DatabaseServiceProtocol.self)
    
    private var allMedicines: [Medicine] = []
    @Published var filteredMedicines: [Medicine] = []
    @Published var searchText: String = "" {
        didSet {
            if searchText.isEmpty {
                filteredMedicines = allMedicines
            } else {
                filteredMedicines = allMedicines.filter {
                    $0.title.lowercased().contains(searchText.lowercased())
                }
            }
        }
    }
    
    func fetchMedicines() {
        let medicines = databaseService?.fetchAllMedicines() ?? []
        allMedicines = medicines
        filteredMedicines = medicines
    }
    
}
