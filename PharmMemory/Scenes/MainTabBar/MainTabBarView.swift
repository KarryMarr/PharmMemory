//
//  MainTabBarView.swift
//  PharmMemory
//
//  Created by Karina Blinova on 18.06.2025.
//
import SwiftUI

struct MainTabBarView: View {
    
    var body: some View {
        TabView {
            MedicinesView()
                .tabItem {
                    Image(systemName: "cross.case")
                    Text("Моя аптечка")
                }
            Text("Список")
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Список покупок")
                }
            Text("Настройки")
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Настройки")
                }
        }
    }
}

#Preview {
    MainTabBarView()
}
