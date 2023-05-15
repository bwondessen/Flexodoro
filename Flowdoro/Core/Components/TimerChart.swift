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
        
        for _ in 0..<weekDays.count {
            var sunday: Double = 0
            var monday: Double = 0
            var tuesday: Double = 0
            var wednesday: Double = 0
            var thursday: Double = 0
            var friday: Double = 0
            var saturday: Double = 0

            for stat in stats {
                if Date.isSameDay(date1: stat.date ?? Date(), date2: weekDays[0]) {
                    sunday += stat.timeStudied
                } else if Date.isSameDay(date1: stat.date ?? Date(), date2: weekDays[1]) {
                    monday += stat.timeStudied
                } else if Date.isSameDay(date1: stat.date ?? Date(), date2: weekDays[2]) {
                    tuesday += stat.timeStudied
                } else if Date.isSameDay(date1: stat.date ?? Date(), date2: weekDays[3]) {
                    wednesday += stat.timeStudied
                } else if Date.isSameDay(date1: stat.date ?? Date(), date2: weekDays[4]) {
                    thursday += stat.timeStudied
                } else if Date.isSameDay(date1: stat.date ?? Date(), date2: weekDays[5]) {
                    friday += stat.timeStudied
                } else if Date.isSameDay(date1: stat.date ?? Date(), date2: weekDays[6]) {
                    saturday += stat.timeStudied
                }
            }
            
            studyTimeThisWeek.append(sunday)
            studyTimeThisWeek.append(monday)
            studyTimeThisWeek.append(tuesday)
            studyTimeThisWeek.append(wednesday)
            studyTimeThisWeek.append(thursday)
            studyTimeThisWeek.append(friday)
            studyTimeThisWeek.append(saturday)
            
//            let nextDayIndex = studyTimeThisWeek.index(after: Int(amount))
//            studyTimeThisWeek[nextDayIndex] = 0
        }
        
        return studyTimeThisWeek
    }
    
    var totalStudyThisWeek: Double {
        var total: Double = 0
        
        for time in timeStudiedThisWeek {
            total += time
        }
        
        return total
    }
    
    var body: some View {
        ZStack {
            //Color(.orange).edgesIgnoringSafeArea(.all)
            VStack {
                Text("Trends")
                    .font(.system(size: 28))
                    .fontWeight(.medium)
                    //.foregroundColor(Color(.white))
//                Picker(selection: $pickerSelectedItem, label: Text("")) {
//                    Text("Weekly").tag(0)
//                    Text("Monthly").tag(1)
//                    Text("Yearly").tag(2)
//                    Text("Leap Year").tag(3)
//                    Text("Weekend").tag(4)
//                }.pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 24)
                HStack(alignment: .bottom, spacing: 20) {
//                    BarView(value: timeStudiedThisWeek[0], week: "Sun")
//                    BarView(value: timeStudiedThisWeek[1], week: "Mon")
//                    BarView(value: timeStudiedThisWeek[2], week: "Tue")
//                    BarView(value: timeStudiedThisWeek[3], week: "Wed")
//                    BarView(value: timeStudiedThisWeek[4], week: "Thur")
//                    BarView(value: timeStudiedThisWeek[5], week: "Fri")
//                    BarView(value: timeStudiedThisWeek[6], week: "Sat")
                    
                    if totalStudyThisWeek > 0 {
                        BarView(value: sundayValue(), week: "Sun")
                        BarView(value: mondayValue(), week: "Mon")
                        BarView(value: tuesdayValue(), week: "Tue")
                        BarView(value: wednesdayValue(), week: "Wed")
                        BarView(value: thursdayValue(), week: "Thur")
                        BarView(value: fridayValue(), week: "Fri")
                        BarView(value: saturdayValue(), week: "Sat")
                    } else {
                        HStack {
                            Spacer()
                            Text("No data to display")
                                .font(.subheadline)
                            Spacer()
                        }
                    }
                }.padding(.top, 24)
                    //.animation(.default)
            }
        }
    }
    
    func sundayValue() -> Double {
        let studyTime = timeStudiedThisWeek[0]
        var totalStudyTime: Double = 0

        for num in 0...6 {
            totalStudyTime += timeStudiedThisWeek[num]
        }

        let studyPercentage = studyTime / totalStudyTime

        let value = studyPercentage * 300

        return value
    }

    func mondayValue() -> Double {
        let studyTime = timeStudiedThisWeek[1]
        var totalStudyTime: Double = 0

        for num in 0...6 {
            totalStudyTime += timeStudiedThisWeek[num]
        }

        let studyPercentage = studyTime / totalStudyTime

        let value = studyPercentage * 300

        return value
    }

    func tuesdayValue() -> Double {
        let studyTime = timeStudiedThisWeek[2]
        var totalStudyTime: Double = 0

        for num in 0...6 {
            totalStudyTime += timeStudiedThisWeek[num]
        }

        let studyPercentage = studyTime / totalStudyTime

        let value = studyPercentage * 300

        return value
    }

    func wednesdayValue() -> Double {
        let studyTime = timeStudiedThisWeek[3]
        var totalStudyTime: Double = 0

        for num in 0...6 {
            totalStudyTime += timeStudiedThisWeek[num]
        }

        let studyPercentage = studyTime / totalStudyTime

        let value = studyPercentage * 300

        return value
    }

    func thursdayValue() -> Double {
        let studyTime = timeStudiedThisWeek[4]
        var totalStudyTime: Double = 0

        for num in 0...6 {
            totalStudyTime += timeStudiedThisWeek[num]
        }

        let studyPercentage = studyTime / totalStudyTime

        let value = studyPercentage * 300

        return value
    }

    func fridayValue() -> Double {
        let studyTime = timeStudiedThisWeek[5]
        var totalStudyTime: Double = 0

        for num in 0...6 {
            totalStudyTime += timeStudiedThisWeek[num]
        }

        let studyPercentage = studyTime / totalStudyTime

        let value = studyPercentage * 300

        return value
    }

    func saturdayValue() -> Double {
        let studyTime = timeStudiedThisWeek[6]
        var totalStudyTime: Double = 0

        for num in 0...6 {
            totalStudyTime += timeStudiedThisWeek[num]
        }

        let studyPercentage = studyTime / totalStudyTime

        let value = studyPercentage * 300

        return value
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
                        RoundedRectangle(cornerRadius: 7.5).frame(width: 30, height: value)
                        RoundedRectangle(cornerRadius: 7.5).frame(width: 30, height: value)
                        RoundedRectangle(cornerRadius: 7.5).frame(width: 30, height: value)
                        RoundedRectangle(cornerRadius: 7.5).frame(width: 30, height: value)
                        RoundedRectangle(cornerRadius: 7.5).frame(width: 30, height: value)
                        RoundedRectangle(cornerRadius: 7.5).frame(width: 30, height: value)
                        RoundedRectangle(cornerRadius: 7.5).frame(width: 30, height: value)
                    }
                    .foregroundColor(.blue)
                }
                Text(week)
                    .font(.caption.bold())
                    .lineLimit(1)
            }
        }
    }
}
