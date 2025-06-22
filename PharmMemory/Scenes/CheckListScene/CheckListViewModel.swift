//
//  CheckListViewModel.swift
//  PharmMemory
//
//  Created by Karina Blinova on 22.06.2025.
//
import SwiftUI

final class CheckListViewModel: ObservableObject {
    @Published var lowStockMedicines: [Medicine] = []
    
    private var medicines: [Medicine] = [] {
        didSet {
            lowStockMedicines = medicines.filter { medicine in
                guard let medicineCount = Int(medicine.count) else { return false }
                return medicineCount < 5
            }
        }
    }
    
    private let databaseService = ServiceLocator.shared.resolve(DatabaseServiceProtocol.self)
    
    func onAppear() {
        medicines = databaseService?.fetchAllMedicines() ?? []
    }
}
