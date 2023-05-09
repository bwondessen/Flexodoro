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
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var tasks: FetchedResults<Tasks>
    
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
            if tasks.isEmpty {
                VStack(alignment: .center) {
                    Text("There are currently no tasks.")
                        .font(.callout.italic())
                        .fontWeight(.semibold)
                    Text("Click the + button in the top right corner of the timer screen to add a task!")
                        .font(.callout.italic())
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding()
                .navigationTitle("Tasks")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                        .tint(.black)
                    }
                }
            } else {
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
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(.white.opacity(0.000001))
                            }
                            .onTapGesture {
                                taskSelected = task
                                dismiss()
                            }
                        }
                    }
                    .onDelete(perform: remove)
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
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                }
            }
        }
    }
    
    func remove(at offsets: IndexSet) {
        for index in offsets {
            let task = tasks[index]
            moc.delete(task)
        }
        
        do {
            try moc.save()
        } catch {
            // handle the Core Data error
        }
    }
}

//struct AddTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTaskView()
//    }
//}
