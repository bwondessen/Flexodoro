//
//  HomeView.swift
//  Flexodoro
//
//  Created by Bruke on 10/24/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var vm = HomeViewModel()
    
    @State private var timeSelected: Double = 60
    @State private var timeRemaining: Double = 60
    @State private var isTimerPuased: Bool = true
    
    @State private var counter: Int = 1
    @State private var sliderUsed: Bool = false
    @State private var offset: CGFloat = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Circle()
                    .stroke(Color.gray.opacity(0.15), lineWidth: 15)
                    .frame(width: UIScreen.main.bounds.width * 0.80)
                    .overlay(
                        ZStack {
                            Circle()
                                .trim(from: 0, to: vm.timeRemainingInPercent(timeSelected: Int(timeSelected), timeRemaining: counter))
                                .stroke(Color.blue, lineWidth: 15)
                                .rotationEffect(.degrees(-90))
                            Text("\(Int(timeSelected) - counter)")
                                .font(.title.bold())
                                .onReceive(vm.timer) { _ in
                                                if timeRemaining > 0 {
                                                    timeRemaining -= 1
                                                }
                                            }
                        }
                    )
                
                startAndPauseButtons
            }
            .navigationTitle("Flexodoro")
            .onAppear(perform: vm.pauseTimer)
            .onChange(of: timeRemaining) { _ in
                inverse()
            }
//            .overlay(
//                EditTimeView(timeSelected: $timeSelected)
//            )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension HomeView {
    private var startAndPauseButtons: some View {
        VStack {
            if isTimerPuased {
                Button {
                    vm.startTimer()
                    isTimerPuased = false
                } label: {
                    ButtonView(label: "Start")
                }
            } else {
                Button {
                    vm.pauseTimer()
                    isTimerPuased = true
                } label: {
                    ButtonView(label: "Pause")
                }
            }
        }
    }
    
    func inverse() -> Int {
        if counter <= Int(timeSelected) {
            counter += 1
        }
        return counter
    }
}
