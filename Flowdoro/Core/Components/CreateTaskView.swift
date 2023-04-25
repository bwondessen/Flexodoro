//
//  AddTaskView.swift
//  Flexodoro
//
//  Created by Bruke on 4/24/23.
//

import SwiftUI

struct CreateTaskView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var stats: FetchedResults<Stats>
    
    @Binding var taskName: String
    @Binding var taskColor: Color
    @Binding var taskCreated: Bool
    
    private let colors: [Color] = [.blue, .red, .purple, .cyan, .yellow, .orange, .green, .black, .brown, .mint, .indigo]
    
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
        List {
            Section("Task Name") {
                TextField("Task Name", text: $taskName)
            }
            
            Section("Task Color") {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(colors, id: \.self) { color in
                            Circle()
                                .foregroundColor(color)
                                .frame(width: 45, height: 45)
                                .opacity(color == taskColor ? 0.5 : 1)
                                .scaleEffect(color == taskColor ? 1.1 : 1)
                                .onTapGesture {
                                    taskColor = color
                                }
                        }
                        
                        VStack {
                            ColorPicker("", selection: $taskColor)
                        }
                    }
                    .padding()
                    .cornerRadius(20)
                }
            }
            .listRowBackground(opacity(0))
            
            Section {
                HStack {
                    Spacer()
                    
                    Button {
                        DataController().addStats(timeStudied: timeStudied, totalTimeStudied: totalTimeStudied, breakTime: breakTime, totalBreakTime: totalBreakTime, taskName: taskName, taskColor: taskColor.description, context: moc)
                    } label: {
                        Text("Add Task")
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Spacer()
                }
            }
            .listRowBackground(opacity(0))
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTaskView(taskName: .constant(""), taskColor: .constant(Color.blue), taskCreated: .constant(false))
    }
}
