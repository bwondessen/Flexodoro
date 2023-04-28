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
            points.append(DataPoint(value: task.totalTimeStudied, label: LocalizedStringKey(String(task.totalTimeStudied) + " seconds"), legend: Legend(color: .gray, label: "\(task.taskName ?? "N/A")", order: 1)))
        }
        
        return points
    }
    
    var body: some View {
        Text("")
        HorizontalBarChartView(dataPoints: taskPoints())
    }
}

struct TaskChart_Previews: PreviewProvider {
    static var previews: some View {
        TaskChart()
    }
}
