//
//  HomeViewModel.swift
//  Flowdoro
//
//  Created by Bruke on 10/24/22.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var isTimerPaused: Bool = true
    
    @Published var focusTime: Double = 15
    @Published var focusTimeRemaining: Double = 15
    @Published var flowTime: Double = 10
    @Published var flowTimeRemaining: Double = 10
    @Published var breakTime: Double = 5
    @Published var breakTimeRemaining: Double = 5
    @Published var flowdoroCycle: Int = 0

    @Published var counter: Int = 0
    
    // Timer
    func startTimer() {
        isTimerPaused = false
        self.timer  = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    func pauseTimer() {
        isTimerPaused = true
        self.timer.upstream.connect().cancel()
    }
    
    func resetTimer() {
        pauseTimer()
        focusTimeRemaining = focusTime
        flowTimeRemaining = flowTime
        breakTimeRemaining = breakTime
        counter = 0
    }
    
    func timeRemainingInPercent(inFocus: Bool, inFlow: Bool, inBreak: Bool) -> Double {
        guard
            focusTimeRemaining >= 0,
            flowTimeRemaining >= 0
        else { return 0 }
        
        if inFocus {
            return Double(counter) / focusTime
        } else if inFlow {
            return Double(counter) / flowTime
        } else {
            return Double(counter) / breakTime
        }
    }
    
    func incrementCounter() -> Int {
        if counter <= Int(focusTime) - 1 {
            counter += 1
        }
        return counter
    }
}
