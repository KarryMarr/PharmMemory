//
//  CheckListView.swift
//  PharmMemory
//
//  Created by Karina Blinova on 22.06.2025.
//
import SwiftUI

private extension CGFloat {
    static let imageSize: CGFloat = 48
}

struct CheckListView: View {
    @StateObject var viewModel = CheckListViewModel()
    
    var body: some View {
        NavigationStack {
            switch viewModel.model.state {
            case .empty:
                emptyStateView
            case .content:
                contentStateView
            }
        }
    }
}

private extension CheckListView {
    var emptyStateView: some View {
        VStack {
            Image(systemName: "checkmark.circle.fill")
                .font(Font.system(size: CGFloat.imageSize))
                .foregroundColor(Color.statusValid)
                .padding()
            
            Text("Все лекарства в достаточном количестве")
                .font(Font.bodyText)
                .foregroundColor(Color.textSecondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
    
    var contentStateView: some View {
        List(viewModel.lowStockMedicines) { medicine in
            MedicineCardView(medicine: medicine)
                .listRowBackground(Color.cardBackground)
                .listRowSeparatorTint(Color.secondarySeparator)
        }
        .listStyle(.plain)
        .navigationTitle("Заканчивается")
        .background(Color.background)
    }
}
