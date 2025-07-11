//
//  TextFieldCellView.swift
//  PharmMemory
//
//  Created by Karina Blinova on 10.07.2025.
//
import SwiftUI

struct TextFieldCellView: View {
    let title: String
    @Binding var subtitle: String
    var keyboardType: UIKeyboardType = .default
    @State private var isEditing = false
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .font(Font.bodyText)
                .foregroundColor(Color.textPrimary)
            Spacer()
            if isEditing || subtitle.isEmpty == false {
                HStack {
                    TextField(String.empty, text: $subtitle)
                        .focused($isFocused)
                        .keyboardType(keyboardType)
                        .environment(\.layoutDirection, .rightToLeft)
                    Button(action: {
                        subtitle = ""
                        isEditing = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .foregroundColor(.blue)
                }
            } else {
                Button("Указать") {
                    isFocused = true
                    isEditing = true
                }
                .foregroundColor(Color.blue)
            }
        }
    }
}
