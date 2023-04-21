//
//  StatsView.swift
//  Flexodoro
//
//  Created by Bruke on 4/18/23.
//

import SwiftUI
import CoreData

struct StatsView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var stats: FetchedResults<Stats>
    
    
    // Time studied
    var totalTimeStudied: Double {
        var totalTime: Double = 0
        for stat in stats {
            totalTime += stat.timeStudied
        }
        
        return totalTime
    }
    
    var timeStudiedToday: Double {
        var amount: Double = 0
        for stat in stats {
            if Calendar.current.dateComponents([.day, .month, .year], from: stat.date ?? Date.now) == Calendar.current.dateComponents([.day, .month, .year], from: Date.now) {
                amount += stat.timeStudied
            }
        }
        
        return amount
    }
    
    // Cycles
    var totalCycles: Int16 {
        var cycles: Int16 = 0
        for stat in stats {
            cycles += stat.cycles
        }
        
        return Int16(cycles)
    }
    
    var cyclesToday: Int16 {
        var amount: Int16 = 0
        for stat in stats {
            if Calendar.current.dateComponents([.day, .month, .year], from: stat.date ?? Date.now) == Calendar.current.dateComponents([.day, .month, .year], from: Date.now) {
                amount += stat.cycles
            }
        }
        
        return amount
    }
        
    // Break time
    var totalBreakTime: Double {
        var totalTime: Double = 0
        for stat in stats {
            totalTime += stat.timeStudied
        }
        
        return totalTime
    }
    
    var breakTimeToday: Double {
        var amount: Double = 0
        for stat in stats {
            if Calendar.current.dateComponents([.day, .month, .year], from: stat.date ?? Date.now) == Calendar.current.dateComponents([.day, .month, .year], from: Date.now) {
                amount += stat.breakTime
            }
        }
        
        return amount
    }
        
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack {
                        Text("Todays Study")
                            .font(.title.bold())
                        Text("\(timeStudiedToday)")
                    }
                    
                    VStack {
                        Text("Todays Cylces")
                            .font(.title.bold())
                        Text("\(cyclesToday)")
                    }
                }
                
                HStack {
                    VStack {
                        Text("Total Study")
                            .font(.title.bold())
                        Text("\(totalTimeStudied)")
                    }
                    
                    VStack {
                        Text("Total Cycles")
                            .font(.title.bold())
                        Text("\(totalCycles)")
                    }
                }
                
                //Text("Today: \(Calendar.current.dateComponents([.day, .month, .year], from: Date.now))")
                
                Text("\(breakTimeToday)")
                                
                TabBarShadow()
            }
            .navigationTitle("Stats")
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
