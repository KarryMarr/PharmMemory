//
//  AutocompleteService.swift
//  PharmMemory
//
//  Created by Karina Blinova on 29.07.2025.
//
import Foundation

private enum AutocompleteServicePaths: String {
    case saveNewMedicine = "saveNewMedicine"
    case getMedicinesByArticle = "getMedicinesByArticle"
}

protocol AutocompleteServiceProtocol {
    func saveNewMedicine(_ medicine: Medicine) async
    func getMedicines(by article: String) async -> [MedicineOption]
}

final class AutocompleteService: AutocompleteServiceProtocol {
    private let baseUrl = "http://89.23.117.5:8080/api/v1/"
    
    func saveNewMedicine(_ medicine: Medicine) async {
        guard let url = URL(string: "\(baseUrl)\(AutocompleteServicePaths.saveNewMedicine.rawValue)"),
              let article = medicine.barcode else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONEncoder().encode(MedicineRequest(
                article: article,
                name: medicine.title,
                dosage: medicine.dose,
                dosageUnits: medicine.dosageUnits.rawValue))
            URLSession.shared.dataTask(with: request).resume()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getMedicines(by article: String) async -> [MedicineOption] {
        do {
            let urlString = "\(baseUrl)\(AutocompleteServicePaths.getMedicinesByArticle.rawValue)?article=\(article)"
            guard let url = URL(string: urlString) else { return [] }
            let data = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode([MedicineOption].self, from: data.0)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
