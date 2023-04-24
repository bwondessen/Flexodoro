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
    
    @Binding var taskName: String
    @Binding var taskColor: Color
    @Binding var taskCreated: Bool
    
    private let colors: [Color] = [.blue, .red, .purple, .cyan, .yellow, .orange, .green, .black, .brown, .mint, .indigo]
    
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
                            Image(systemName: "paintbrush.pointed")
                                .resizable()
                                .frame(width: 45, height: 45)
//                            Text("Custom")
//                                .font(.caption.italic())
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
        AddTaskView(taskName: .constant(""), taskColor: .constant(Color.blue), taskCreated: .constant(false))
    }
}
