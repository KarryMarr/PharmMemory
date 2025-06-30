//
//  CheckListViewModel.swift
//  PharmMemory
//
//  Created by Karina Blinova on 22.06.2025.
//
import SwiftUI

final class CheckListViewModel: ObservableObject {
    private let databaseService = ServiceLocator.shared.resolve(DatabaseServiceProtocol.self)
    
    @Published var lowStockMedicines: [Medicine] = []
    
    var model = CheckListModel(state: .empty)
    private var medicines: [Medicine] = [] {
        didSet {
            lowStockMedicines = medicines.filter { medicine in
                guard let medicineCount = Int(medicine.count) else { return false }
                return medicineCount < 5
            }
        }
    }
    
    func onAppear() {
        medicines = databaseService?.fetchAllMedicines() ?? []
        model.state = lowStockMedicines.isEmpty ? .empty : .content
    }
}
