//
//  MainView.swift
//  Flexodoro
//
//  Created by Bruke on 5/2/23.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedTab = "homeView"
    
    var body: some View {
        if vm.isSignedUp && vm.isLoggedIn {
            mainView
        } else if vm.isSignedUp && vm.isLoggedIn {
            mainView
        } else if vm.isSignedUp && !vm.isLoggedIn {
            NavigationView {
                Login()
            }
        } else {
            SignUp()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

extension MainView {
    var mainView: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "deskclock")
                }
                .tag("homeView")
            
            StatsView()
                .tabItem {
                    Image(systemName: "chart.bar")
                }
                .tag("statsView")
        }
    }
}
