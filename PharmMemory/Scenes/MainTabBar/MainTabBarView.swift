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
            MedicineListView()
                .tabItem {
                    Image(systemName: "cross.case")
                    Text("Моя аптечка")
                }
            CheckListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Список покупок")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Настройки")
                }
        }
    }
}
