////
////  TimerChart.swift
////  Flexodoro
////
////  Created by Bruke on 4/28/23.
////
//
//import SwiftUI
//import SwiftUICharts
//
//struct TimerChart: View {
//    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var stats: FetchedResults<Stats>
//    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var tasks: FetchedResults<Tasks>
//
//    //    let warmUp = Legend(color: .blue, label: "Warm Up", order: 2)
//    //    let low = Legend(color: .gray, label: "Low", order: 1)
//
//    //    let points: [DataPoint] = [
//    //        .init(value: 70, label: "1", legend: Legend(color: .gray, label: "Low", order: 1)),
//    //        .init(value: 90, label: "2", legend: Legend(color: .blue, label: "Warm Up", order: 2)),
//    //        .init(value: 91, label: "3", legend: Legend(color: .blue, label: "Warm Up", order: 2)),
//    //        .init(value: 92, label: "4", legend: Legend(color: .blue, label: "Warm Up", order: 2))
//    //    ]
//
//    func taskPoints() -> [DataPoint] {
//        var points: [DataPoint] = []
//
//        for task in tasks {
//            points.append(DataPoint(value: task.totalTimeStudied, label: LocalizedStringKey(String(task.totalTimeStudied) + " seconds"), legend: Legend(color: Color(task.taskColor ?? "gray"), label: "\(task.taskName ?? "N/A")", order: 1)))
//        }
//
//        return points
//    }
//
//    var body: some View {
//        BarChartView(dataPoints: taskPoints())
//            .chartStyle(
//                BarChartStyle(
//                    //barMinHeight: 100,
//                    showAxis: false,
//                    axisLeadingPadding: 0,
//                    showLabels: true,
//                    labelCount: 5,
//                    showLegends: false
//                )
//            )
//    }
//}
//
//struct TimerChart_Previews: PreviewProvider {
//    static var previews: some View {
//        TimerChart()
//    }
//}








import SwiftUI

struct TimerChart: View {
    @EnvironmentObject private var vm: HomeViewModel
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var stats: FetchedResults<Stats>
    
    @State private var pickerSelectedItem = 0
    @State private var dataPoints: [[CGFloat]] = [
        [100, 120, 150],
        [150, 100, 120],
        [120, 150, 100],
        [120, 100, 150],
        [130, 50, 100]
    ]
    
    let weekDays: [Date] = [Date.sunday(using: Calendar.current), Date.monday(using: Calendar.current), Date.tuesday(using: Calendar.current), Date.wednesday(using: Calendar.current), Date.thursday(using: Calendar.current), Date.friday(using: Calendar.current), Date.saturday(using: Calendar.current)]
    
    // Time studied this week
    var timeStudiedThisWeek: [Double] {
//        var amount: Double = 0
        var studyTimeThisWeek: [Double] = []
        
//        for stat in stats {
//            if Calendar.current.dateComponents([.day, .month, .year], from: stat.date ?? Date.now) == Calendar.current.dateComponents([.day, .month, .year], from: Date.now) {
//                amount += stat.timeStudied
//            }
//        }
        
        for day in weekDays {
            var amount: Double = 0
            for stat in stats {
                if Date.isSameDay(date1: stat.date ?? Date(), date2: day) {
                    amount += stat.timeStudied
                }
            }
            studyTimeThisWeek.append(amount)
        }
        
        return studyTimeThisWeek
    }
    
    var body: some View {
        ZStack {
            //Color(.orange).edgesIgnoringSafeArea(.all)
            VStack {
                Text("Trends")
                    .font(.system(size: 28))
                    .fontWeight(.medium)
                    //.foregroundColor(Color(.white))
                Picker(selection: $pickerSelectedItem, label: Text("")) {
                    Text("Weekly").tag(0)
                    Text("Monthly").tag(1)
                    Text("Yearly").tag(2)
                    Text("Leap Year").tag(3)
                    Text("Weekend").tag(4)
                }.pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 24)
                HStack(alignment: .bottom, spacing: 8) {
                    BarView(value: timeStudiedThisWeek[0], week: "Sun")
                    BarView(value: timeStudiedThisWeek[1], week: "Mon")
                    BarView(value: timeStudiedThisWeek[2], week: "Tue")
                    BarView(value: timeStudiedThisWeek[3], week: "Wed")
                    BarView(value: timeStudiedThisWeek[4], week: "Thur")
                    BarView(value: timeStudiedThisWeek[5], week: "Fr")
                    BarView(value: timeStudiedThisWeek[6], week: "Sat")
                }.padding(.top, 24)
                    .animation(.default)
            }
        }
    }
}

extension TimerChart {
    struct BarView: View {
        var value: CGFloat = 0
        var week: String = ""
        var body: some View {
            VStack {
                ZStack(alignment: .bottom) {
                    Group {
                        Capsule().frame(width: 30, height: value)
                        Capsule().frame(width: 30, height: value)
                        Capsule().frame(width: 30, height: value)
                        Capsule().frame(width: 30, height: value)
                        Capsule().frame(width: 30, height: value)
                        Capsule().frame(width: 30, height: value)
                        Capsule().frame(width: 30, height: value)
                    }
                    .foregroundColor(.blue)
                }
                Text(week)
            }
        }
    }
}
