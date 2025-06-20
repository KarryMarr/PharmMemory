//
//  MedicinesViewModel.swift
//  PharmMemory
//
//  Created by Karina Blinova on 18.06.2025.
//
import SwiftUI

final class MedicinesViewModel: ObservableObject {
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
        
    }
    
}
