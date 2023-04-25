//
//  AddTaskView.swift
//  Flexodoro
//
//  Created by Bruke on 4/24/23.
//

import SwiftUI

struct AddTaskView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var stats: FetchedResults<Stats>
    
    @Binding var taskSelected: Bool
    
    private let colors: [Color] = [.blue, .red, .purple, .cyan, .pink, .yellow, .orange, .teal, .green, .black, .brown, .mint, .gray, .indigo]
        
    // Time studied
    var timeStudied: Double {
        (vm.focusTime - vm.focusTimeRemaining) + (vm.flowTime - vm.flowTimeRemaining)
    }
    
    var totalTimeStudied: Double {
        var totalTime: Double = 0
        for stat in stats {
            totalTime += stat.timeStudied
        }
        
        return totalTime
    }
    
    // Break time
    var breakTime: Double {
        vm.breakTime - vm.breakTimeRemaining
    }
    
    var totalBreakTime: Double {
        var totalTime: Double = 0
        for stat in stats {
            totalTime += stat.breakTime
        }
        
        return totalTime
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(stats, id: \.self) { stat in
                    if stat.taskName != nil {
                        HStack {
                            Circle()
                                .foregroundColor(Color(stat.taskColor ?? "N/A"))
                                .frame(width: 25, height: 25)
                            Text(stat.taskName ?? "N/A")
                                .bold()
                        }
                    }
                }
            }
            .navigationTitle("Tasks")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//struct AddTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTaskView()
//    }
//}
