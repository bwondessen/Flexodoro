//
//  HomeView.swift
//  Flexodoro
//
//  Created by Bruke on 10/24/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var vm = HomeViewModel()
    
    @State private var focusTime: Double = 15
    @State private var flexTime: Double = 10
    @State private var breakTime: Double = 5
    @State private var timeRemaining: Double = 60
    @State private var isTimerPuased: Bool = true
    
    @State private var counter: Int = 1
    
    @State private var showEditTimerPopupView: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        VStack {
                            Text("Window")
                            Text(flexTime.asNumberString())
                        }
                        VStack {
                            Text("Focus")
                            Text(focusTime.asNumberString())
                        }
                        .onTapGesture {
                            showEditTimerPopupView = true
                        }
                        VStack {
                            Text("Break")
                            Text(breakTime.asNumberString())
                        }
                    }
                    Text("focus time: \(focusTime)")
                    Text("time remaining \(timeRemaining)")
                    timerView
                    startAndPauseButtons
                    Button {
                        vm.resetTimer(timeSelected: focusTime, timeRemaining: &timeRemaining)
                    } label: {
                        Text("reset")
                    }

                }
                .navigationTitle("Flexodoro")
                .onAppear(perform: vm.pauseTimer)
                .onChange(of: timeRemaining) { _ in
                    inverse()
                }
    //            .overlay(
    //                EditTimeView(timeSelected: $timeSelected)
    //            )
                EditTimerPopupView(showEditTimerPopupView: $showEditTimerPopupView, timeSelected: $focusTime)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension HomeView {
    private var timerView: some View {
        Circle()
            .stroke(Color.theme.buttonBackground, lineWidth: 15)
            .frame(width: UIScreen.main.bounds.width * 0.80, height: UIScreen.main.bounds.height * 0.45)
            .overlay(
                ZStack {
                    Circle()
                        .trim(from: 0, to: vm.timeRemainingInPercent(timeSelected: Int(focusTime), timeRemaining: counter))
                        .stroke(Color.theme.accent, lineWidth: 15)
                        .rotationEffect(.degrees(-90))
                    Text("\(Int(focusTime + 1) - counter)")
                        .font(.title.bold())
                        .onReceive(vm.timer) { _ in
                                        if timeRemaining > 0 {
                                            timeRemaining -= 1
                                        }
                                    }
                }
            )
    }
    
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
        if counter <= Int(focusTime) {
            counter += 1
        }
        return counter
    }
}
