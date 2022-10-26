//
//  HomeViewModel.swift
//  Flexodoro
//
//  Created by Bruke on 10/24/22.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func startTimer() {
        self.timer  = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    func pauseTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    func resetTimer(timeSelected: Double, timeRemaining: inout Double) {
        timeRemaining = timeSelected
    }
    
    func timeRemainingInPercent(timeSelected: Int, timeRemaining: Int) -> Double {
        guard timeSelected > 0 else { return 0 }
        
        var inverseValue = 0
        
        
        return Double(timeRemaining) / Double(timeSelected)
    }
}
