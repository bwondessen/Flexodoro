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
    @Published var timerPaused: Bool = true
    
    @Published var focusTime: Double = 5
    @Published var focusTimeRemaining: Double = 5
    @Published var flowTime: Double = 4
    @Published var flowTimeRemaining: Double = 4
    @Published var breakTime: Double = 3
    @Published var breakTimeRemaining: Double = 3
    @Published var totalCycles: Int = 0
    
    @Published var inFocus: Bool = true
    @Published var inFlow: Bool = false
    @Published var inBreak: Bool = false
    
    @Published var focusSelected: Bool = false
    @Published var flowSelected: Bool = false
    @Published var breakSelected: Bool = false
    
    @Published var counter: Int = 0
    
    // Timer
    func startTimer() {
        timerPaused = false
        self.timer  = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    func pauseTimer() {
        timerPaused = true
        self.timer.upstream.connect().cancel()
    }
    
    func restartTimer() {
        pauseTimer()
        if !inFocus {
            focusTimeRemaining = focusTime
        }
        flowTimeRemaining = flowTime
        breakTimeRemaining = breakTime
        counter = 0
    }
    
    func end() {
        if inBreak && breakTimeRemaining > 0 {
            totalCycles += 1
        }
        pauseTimer()
        inFocus = true
        inFlow = false
        inBreak = false
        focusTimeRemaining = focusTime
        flowTimeRemaining = flowTime
        breakTimeRemaining = breakTime
        counter = 0
    }
    
    func skip() {
        if focusTime > focusTimeRemaining {
            pauseTimer()
            restartTimer()
            if inFocus {
                inFocus = false
                inFlow = true
                inBreak = false
            } else if inFlow {
                inFocus = false
                inFlow = false
                inBreak = true
            } else if inBreak {
                end()
            }
        }
    }
    
    func timeRemainingInPercent() -> Double {
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
