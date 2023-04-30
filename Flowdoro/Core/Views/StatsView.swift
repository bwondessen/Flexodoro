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
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var tasks: FetchedResults<Tasks>
    
    
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
            totalTime += stat.breakTime
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
    
    // Task studied the most
    var mostStudiedTask: Tasks {
        var arr: [Tasks] = []
        
        for task in tasks {
            arr.append(task)
        }
        
        let mostStudied = arr.max { $0.totalTimeStudied < $1.totalTimeStudied }
        
        return mostStudied ?? Tasks()
    }
        
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack {
                    statsSection
                    VStack {
//                        Text("\(Date.monday(using: Calendar.current))")
//                        Text("\(Date.friday(using: Calendar.current))")
//                        Text(Date.isSameDay(date1: Date.saturday(using: Calendar.current), date2: Date()) ? "true" : "false")
//                        Text("\(Calendar.current.dateComponents([.day, .month, .year], from: Date()))")
                        
                        TaskChart()
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.white)
                                    .shadow(radius: 2.5)
                            }
                        TimerChart()
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.white)
                                    .shadow(radius: 2.5)
                            }
                    }
                    .padding()
                    
                    TabBarShadow()
                }
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

extension StatsView {
    private var statsSection: some View {
        VStack {
            HStack {
                TimerStatsView(title: "Todays Study", value: "\(timeStudiedToday)")
                TimerStatsView(title: "Total Study", value: "\(totalTimeStudied)")
            }
            
            HStack {
                TimerStatsView(title: "Todays Cycles", value: "\(cyclesToday)")
                TimerStatsView(title: "Total Cycles", value: "\(totalCycles)")
            }
            
            HStack {
                TimerStatsView(title: "Todays Break", value: "\(breakTimeToday)")
                TimerStatsView(title: "Total Break", value: "\(totalBreakTime)")
            }
            
            HStack {
                TimerStatsView(title: "Top Task", value: "\(mostStudiedTask.taskName ?? "N/A")")
                TimerStatsView(title: "TT#", value: "\(timeStudiedToday)")
            }
        }
    }
}

/*
 HStack {
     VStack {
         Text("Top Task")
             .font(.title.bold())
         Text("\(mostStudiedTask.taskName ?? "N/A")")
     }
     
     VStack {
         Text("TT#")
             .font(.title.bold())
         Text("\(mostStudiedTask.totalTimeStudied)")
     }
 }
 */



/*
 //
 //  TaskChart.swift
 //  Flexodoro
 //
 //  Created by Bruke on 4/27/23.
 //

 import SwiftUI
 import SwiftUICharts

 struct TaskChart: View {
     @Environment(\.managedObjectContext) var moc
     @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var stats: FetchedResults<Stats>
     @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var tasks: FetchedResults<Tasks>
     
 //    let warmUp = Legend(color: .blue, label: "Warm Up", order: 2)
 //    let low = Legend(color: .gray, label: "Low", order: 1)

 //    let points: [DataPoint] = [
 //        .init(value: 70, label: "1", legend: Legend(color: .gray, label: "Low", order: 1)),
 //        .init(value: 90, label: "2", legend: Legend(color: .blue, label: "Warm Up", order: 2)),
 //        .init(value: 91, label: "3", legend: Legend(color: .blue, label: "Warm Up", order: 2)),
 //        .init(value: 92, label: "4", legend: Legend(color: .blue, label: "Warm Up", order: 2))
 //    ]
     
     func taskPoints() -> [DataPoint] {
         var points: [DataPoint] = []
         
         for task in tasks {
             points.append(DataPoint(value: task.totalTimeStudied, label: LocalizedStringKey(String(task.totalTimeStudied) + " seconds"), legend: Legend(color: Color(task.taskColor ?? "gray"), label: "\(task.taskName ?? "N/A")", order: 1)))
         }
         
         return points
     }
     
     var body: some View {
         HorizontalBarChartView(dataPoints: taskPoints())
     }
 }

 struct TaskChart_Previews: PreviewProvider {
     static var previews: some View {
         TaskChart()
     }
 }

 */
