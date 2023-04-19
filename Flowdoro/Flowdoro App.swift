//
//  FlowdoroApp.swift
//  Flowdoro
//
//  Created by Bruke on 10/24/22.
//

import SwiftUI

@main
struct FlexodoroApp: App {
    @StateObject private var vm = HomeViewModel()
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView()
                    .environmentObject(vm)
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .tabItem {
                        Label("Timer", systemImage: "deskclock")
                    }
                StatsView()
                    .environmentObject(vm)
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .tabItem {
                        Label("Stats", systemImage: "chart.bar")
                    }
            }
        }
    }
}
