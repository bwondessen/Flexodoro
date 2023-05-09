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
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var tasks: FetchedResults<Tasks>
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var taskName: String
    @Binding var taskColor: Color?
    @Binding var taskCreated: Bool
    
    @Binding var includeXMark: Bool
    
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
            if includeXMark {
                List {
                    Section("Task Name") {
                        TextField("Task Name", text: $taskName)
                    }
                    
                    Section("Task Color") {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                Image(systemName: "circle")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 45))
                                    .scaleEffect(taskColor == nil ? 1.1 : 1)
                                    .onTapGesture {
                                        taskColor = nil
                                    }
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
                                
        //                        VStack {
        //                            ColorPicker("", selection: $taskColor)
        //                        }
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
                                if taskColor != nil {
                                    DataController().addTasks(taskName: taskName, taskColor: taskColor?.description, timeStudied: 0, totalTimeStudied: 0, context: moc)
                                } else {
                                    DataController().addTasks(taskName: taskName, timeStudied: 0, totalTimeStudied: 0, context: moc)
                                }
                                dismiss()
                            } label: {
                                Text("Add Task")
                            }
                            .buttonStyle(.borderedProminent)
                            .disabled(taskName.isEmpty)
                            
                            Spacer()
                        }
                    }
                    .listRowBackground(opacity(0))
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
                .navigationTitle("Create Task")
                .navigationBarTitleDisplayMode(.inline)
    //            .toolbar {
    //                ToolbarItem {
    //                    Button {
    //                        dismiss()
    //                    } label: {
    //                        Image(systemName: "xmark")
    //                    }
    //                    .tint(.black)
    //                }
    //            }
                .onAppear {
                    taskName = ""
                    taskColor = nil
                }
            } else {
                List {
                    Section("Task Name") {
                        TextField("Task Name", text: $taskName)
                    }
                    
                    Section("Task Color") {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                Image(systemName: "circle")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 45))
                                    .scaleEffect(taskColor == nil ? 1.1 : 1)
                                    .onTapGesture {
                                        taskColor = nil
                                    }
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
                                
        //                        VStack {
        //                            ColorPicker("", selection: $taskColor)
        //                        }
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
                                if taskColor != nil {
                                    DataController().addTasks(taskName: taskName, taskColor: taskColor?.description, timeStudied: 0, totalTimeStudied: 0, context: moc)
                                } else {
                                    DataController().addTasks(taskName: taskName, timeStudied: 0, totalTimeStudied: 0, context: moc)
                                }
                                dismiss()
                            } label: {
                                Text("Add Task")
                            }
                            .buttonStyle(.borderedProminent)
                            .disabled(taskName.isEmpty)
                            
                            Spacer()
                        }
                    }
                    .listRowBackground(opacity(0))
                }
                .navigationTitle("Create Task")
                .navigationBarTitleDisplayMode(.inline)
    //            .toolbar {
    //                ToolbarItem {
    //                    Button {
    //                        dismiss()
    //                    } label: {
    //                        Image(systemName: "xmark")
    //                    }
    //                    .tint(.black)
    //                }
    //            }
                .onAppear {
                    taskName = ""
                    taskColor = nil
                }
            }
        }
    }
}

//struct AddTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateTaskView(taskName: .constant(""), taskColor: .constant(Color.blue), taskCreated: .constant(false), includeXMark: .constant(true))
//    }
//}
