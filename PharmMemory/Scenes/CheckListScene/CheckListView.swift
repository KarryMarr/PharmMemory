//
//  CheckListView.swift
//  PharmMemory
//
//  Created by Karina Blinova on 22.06.2025.
//
import SwiftUI

struct CheckListView: View {
    @StateObject var viewModel = CheckListViewModel()
    
    var body: some View {
        NavigationStack {
            if viewModel.lowStockMedicines.isEmpty {
                VStack {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 48))
                        .foregroundColor(.statusValid)
                        .padding()
                    
                    Text("Все лекарства в достаточном количестве")
                        .font(.bodyText)
                        .foregroundColor(.textSecondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.background)
            } else {
                List(viewModel.lowStockMedicines) { medicine in
                    MedicineCardView(medicine: medicine)
                        .listRowBackground(Color.cardBackground)
                        .listRowSeparatorTint(Color.separator)
                }
                .listStyle(.plain)
                .navigationTitle("Заканчивается")
                .background(Color.background)
            }
        }
    }
}
