//
//  FlowdoroApp.swift
//  Flowdoro
//
//  Created by Bruke on 10/24/22.
//

import SwiftUI
//import Firebase

@main
struct FlexodoroApp: App {
    @StateObject private var vm = HomeViewModel()
    @StateObject private var dataController = DataController()
    
//    init() {
//        FirebaseApp.configure()
//    }
    
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView()
                    .environmentObject(vm)
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .tabItem {
                        Image(systemName: "deskclock")
                    }
                StatsView()
                    .environmentObject(vm)
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .tabItem {
                        Image(systemName: "chart.bar")
                    }
            }
        }
    }
}
