//
//  AddTaskView.swift
//  Flexodoro
//
//  Created by Bruke on 4/24/23.
//

import SwiftUI

struct SelectTaskView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var stats: FetchedResults<Stats>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id, order: .reverse)]) var tasks: FetchedResults<Tasks>
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var taskSelected: Tasks?
    
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
                ForEach(tasks) { task in
                    if task.taskName != nil {
                        Section {
                            HStack {
                                Circle()
                                    .foregroundColor(Color(task.taskColor ?? "N/A"))
                                    .frame(width: 15, height: 15)
                                Text(task.taskName ?? "N/A")
                                    .bold()
                            }
                        }
                        .onTapGesture {
                            taskSelected = task
                            dismiss()
                        }
                    }
                }
            }
            .navigationTitle("Tasks")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .tint(.black)
                }
            }
        }
    }
}

//struct AddTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTaskView()
//    }
//}
