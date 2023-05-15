//
//  HomeView.swift
//  Flowdoro
//
//  Created by Bruke on 10/24/22.
//

import SwiftUI
import UserNotifications
import CoreData

struct HomeView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var stats: FetchedResults<Stats>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var tasks: FetchedResults<Tasks>
    @StateObject private var delegate = NotificationDelegate()
    
    @State private var showEditTimerPopupView: Bool = false
    @State private var showCreateTaskSheet: Bool = false
    @State private var taskName: String = ""
    @State private var taskColor: Color? = nil
    @State private var taskCreated: Bool = false
    @State private var taskSelected: Tasks?
    @State private var showAddTaskSheet: Bool = false
    
    @State private var selectedTime: Double = 1
        
    @State private var taskTimes: [String: Double] = UserDefaults.standard.dictionary(forKey: "taskTimes") as? [String: Double] ?? [:]
    
    @State private var includeXMark: Bool = true
    
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
    
//    // Time studied per task
//    var totalTimeStudiedForTask: Double {
//        //var totalTime: Double = 0
//        for stat in stats {
//            if taskSelected == stat {
//                DispatchQueue.main.async {
//                    taskTimes[taskSelected?.taskName ?? "N/A"] = (vm.focusTime - vm.focusTimeRemaining) + (vm.flowTime - vm.flowTimeRemaining)
//                }
//                if !taskTimes.keys.contains(taskSelected?.taskName ?? "N/A")  {
//                    DispatchQueue.main.async {
//                        taskTimes[taskSelected?.taskName ?? "N/A"] = taskTimes[taskSelected?.taskName ?? "N/A"]
//                        UserDefaults.standard.set(taskTimes, forKey: "taskTimes")
//                    }
//                } else {
//                    DispatchQueue.main.async {
//                        taskTimes[taskSelected?.taskName ?? "N/A"] = taskTimes[taskSelected?.taskName ?? "N/A"]
//                        UserDefaults.standard.set(taskTimes, forKey: "taskTimes")
//                    }
//                }
//            }
//        }
//
//        return taskTimes[taskSelected?.taskName ?? "N/A"] ?? 0
//    }
        
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
            ZStack {
                VStack {
                    HStack {
                        VStack {
                            Text("Flow")
                                .font(.headline.bold())
                            Text(vm.flowTime.asString(style: .abbreviated))
                                .font(.subheadline)
                        }
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width * 0.18, height: UIScreen.main.bounds.height * 0.025)
                        .scaleEffect(vm.inFlow ? 1.1 : 1)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.black, lineWidth: vm.inFlow ? 3.5 : 0)
                                .background {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.blue)
                                }
                        }
                        .onTapGesture {
                            vm.focusSelected = false
                            vm.flowSelected = true
                            vm.breakSelected = false
                            showEditTimerPopupView = true
                        }
                        VStack {
                            Text("Focus")
                                .font(.headline.bold())
                            Text(vm.focusTime.asString(style: .abbreviated))
                                .font(.subheadline)
                        }
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width * 0.18, height: UIScreen.main.bounds.height * 0.025)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.black, lineWidth: vm.inFocus ? 3.5 : 0)
                                .background {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.blue)
                                }
                                //.shadow(radius: 2.5)
                        }
                        .padding(.horizontal)
                        .onTapGesture {
                            vm.focusSelected = true
                            vm.flowSelected = false
                            vm.breakSelected = false
                            showEditTimerPopupView = true
                        }
                        VStack {
                            Text("Break")
                                .font(.headline.bold())
                            Text(vm.breakTime.asString(style: .abbreviated))
                                .font(.subheadline)
                        }
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width * 0.18, height: UIScreen.main.bounds.height * 0.025)
                        .scaleEffect(vm.inBreak ? 1.1 : 1)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.black, lineWidth: vm.inBreak ? 3.5 : 0)
                                .background {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.blue)
                                }
                        }
                        .onTapGesture {
                            vm.focusSelected = false
                            vm.flowSelected = false
                            vm.breakSelected = true
                            showEditTimerPopupView = true
                        }
                    }
                    .padding(.top)
                    .padding()
                    
//                    Group {
//                                                Text("focus time: \(vm.focusTime)")
//                                                Text("focus time remaining: \(vm.focusTimeRemaining)")
//                                                Text("flow time: \(vm.flowTime)")
//                                                Text("flow time remaining: \(vm.flowTimeRemaining)")
//                                                Text("break time: \(vm.breakTime)")
//                                                Text("break time remaining: \(vm.breakTimeRemaining)")
//                                                Text("counter: \(vm.counter)")
//                                                Text("total cycles: \(vm.totalCycles)")
//                        ScrollView {
//                            ForEach(stats) { stat in
//                                if Calendar.current.dateComponents([.day, .month, .year], from: stat.date ?? Date.now) == Calendar.current.dateComponents([.day, .month, .year], from: Date.now) {
//                                    Text("betski: \(stat.date ?? Date())")
//                                }
//                            }
//                        }
//                        .frame(height: 55)
//                    }
                    
//                    if taskSelected != nil {
//                        Text("Task Selected: \(taskSelected?.taskName ?? "N/A")")
//                        Text("You studied \(taskSelected?.taskName ?? "N/A") for \(totalTimeStudiedForTask) secods")
//                    }
                    
                    timerView
                    
                    HStack {
                        focusButton
                            .padding(.bottom)
                    }
                    .onChange(of: vm.breakTimeRemaining) { _ in
                        if vm.breakTimeRemaining == 0 {
                            //vm.resetCycle()
                            vm.totalCycles += 1
                        }
                    }
                    
                    //TabBarShadow()
                }
                .onChange(of: vm.flowTimeRemaining) { _ in
                    if vm.flowTimeRemaining == 0 {
                        vm.pauseTimer()
                        vm.inFlow = false
                        vm.inFocus = false
                        vm.inBreak = true
                        vm.counter = 0
                    }
                }
                .navigationTitle(showEditTimerPopupView ? "" : "Flexodoro")
                .onAppear(perform: vm.pauseTimer)
                //            .overlay(
                //                EditTimeView(timeSelected: $timeSelected)
                //            )
                
//                withAnimation {
//                    EditTimerPopupView(showEditTimerPopupView: $showEditTimerPopupView)
//                }
            }
            .overlay(
                    //EditTimerPopupView(showEditTimerPopupView: $showEditTimerPopupView)
                VStack {
                    EditTimerPopupView(showEditTimerPopupView: $showEditTimerPopupView)
                        //.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.30)
                    //Spacer()
                }
            )
            .onChange(of: vm.focusTimeRemaining) { _ in
                if vm.focusTimeRemaining == 0 {
                    vm.inFlow = true
                    vm.inFocus = false
                    vm.inBreak = false
                    vm.counter = 0
                    if vm.inFlow {
                        vm.startTimer()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if showEditTimerPopupView {
                        
                    } else {
                        Button {
                            showCreateTaskSheet.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .font(.body.bold())
                        }
                        .sheet(isPresented: $showCreateTaskSheet) {
                            if #available(iOS 16.0, *) {
                                CreateTaskView(taskName: $taskName, taskColor: $taskColor, taskCreated: $taskCreated, includeXMark: $includeXMark)
                                    .presentationDetents([.medium])
                            } else {
                                // Fallback on earlier versions
                                CreateTaskView(taskName: $taskName, taskColor: $taskColor, taskCreated: $taskCreated, includeXMark: $includeXMark)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension HomeView {
    private var timerView: some View {
        VStack {
            if taskSelected == nil {
                Button {
                    showAddTaskSheet.toggle()
                } label: {
                    Text("Select task")
                        .font(.callout.italic())
                        .padding(.top)
                }
                .sheet(isPresented: $showAddTaskSheet) {
                    SelectTaskView(taskSelected: $taskSelected)
                }
            } else {
                HStack {
                    Text("\(taskSelected?.taskName ?? "N/A")")
                        .font(.headline.bold())
                        .padding(.top)
                    Button {
                        taskSelected = nil
                    } label: {
                        Image(systemName: "xmark")
                            .font(.callout.italic())
                            .padding(.top)
                    }
                }
            }
            
            Circle()
                .stroke(Color.theme.buttonBackground, lineWidth: 15)
                .frame(width: UIScreen.main.bounds.width * 0.80, height: UIScreen.main.bounds.height * 0.43)
                .overlay(
                    ZStack {
                        Circle()
                            .trim(from: 0, to: vm.timeRemainingInPercent())
                            .stroke(Color.theme.accent, lineWidth: 15)
                            .rotationEffect(.degrees(-90))
                        Text(vm.inFocus ? "\(vm.focusTimeRemaining.asString(style: .positional))" : (vm.inFlow ? "\(vm.flowTimeRemaining.asString(style: .positional))" : "\(vm.breakTimeRemaining.asString(style: .positional))"))
                            .font(.title.bold())
                            .onReceive(vm.timer) { _ in
                                if vm.inFocus {
                                    if vm.focusTimeRemaining > 0 {
                                        vm.focusTimeRemaining -= 1
                                        vm.counter += 1
                                    }
                                }
                                if vm.inFlow {
                                    if vm.flowTimeRemaining > 0 {
                                        vm.flowTimeRemaining -= 1
                                        vm.counter += 1
                                    }
                                }
                                if vm.inBreak {
                                    if vm.breakTimeRemaining > 0 {
                                        vm.breakTimeRemaining -= 1
                                        vm.counter += 1
                                    }
                                }
                            }
                    }
                )
        }
    }
    
    private var focusButton: some View {
        // Skip button
        HStack {
            if vm.inFocus {
                if vm.timerPaused && vm.focusTimeRemaining > 0 {
                    Button {
                        vm.skip()
                    } label: {
                        ButtonView(label: "Skip", selectSmallerSize: true)
                    }
                }
            } else if vm.inFlow {
                if vm.timerPaused && vm.flowTimeRemaining > 0 {
                    Button {
                        vm.skip()
                    } label: {
                        ButtonView(label: "Skip", selectSmallerSize: true)
                    }
                }
            } else if vm.inBreak {
                if vm.timerPaused && vm.breakTimeRemaining > 0 {
                    Button {
                        DataController().addStats(timeStudied: timeStudied, totalTimeStudied: totalTimeStudied, breakTime: breakTime, totalBreakTime: totalBreakTime, context: moc)
                        //vm.skip()
                        taskSelected?.totalTimeStudied += timeStudied
                        try? moc.save()
                        vm.end()
                    } label: {
                        ButtonView(label: "Skip", selectSmallerSize: true)
                    }
                }
            }
            
            // Start button
            VStack {
                if vm.inFocus {
                    if vm.timerPaused && vm.focusTimeRemaining > 0 {
                        Button {
                            vm.startTimer()
                            userNotification()
                        } label: {
                            ButtonView(label: "Focus")
                        }
                    } else if !vm.timerPaused && vm.focusTimeRemaining > 0 {
                        Button {
                            vm.pauseTimer()
                        } label: {
                            ButtonView(label: "Pause")
                        }
                    } else if vm.focusTimeRemaining == 0 {
                        Button {
                            vm.restartTimer()
                        } label: {
                            ButtonView(label: "End")
                        }
                    }
                } else if vm.inFlow {
                    if vm.timerPaused && vm.flowTimeRemaining > 0 {
                        Button {
                            vm.startTimer()
                            userNotification()
                        } label: {
                            ButtonView(label: "Flow")
                        }
                    } else if !vm.timerPaused && vm.flowTimeRemaining > 0 {
                        Button {
                            vm.pauseTimer()
                        } label: {
                            ButtonView(label: "Pause")
                        }
                    }
                } else if vm.inBreak {
                    if vm.timerPaused && vm.breakTimeRemaining > 0 {
                        Button {
                            vm.startTimer()
                            userNotification()
                        } label: {
                            ButtonView(label: "Break")
                        }
                    } else if !vm.timerPaused && vm.breakTimeRemaining > 0 {
                        Button {
                            vm.pauseTimer()
                        } label: {
                            ButtonView(label: "Pause")
                        }
                    } else if vm.breakTimeRemaining == 0 {
                        Button {
                            DataController().addStats(timeStudied: timeStudied, totalTimeStudied: totalTimeStudied, breakTime: breakTime, totalBreakTime: totalBreakTime, context: moc)
                            taskSelected?.totalTimeStudied += timeStudied
                            try? moc.save()
                            vm.end()
                        } label: {
                            ButtonView(label: "Reset")
                        }
                    }
                } else {
                    Button {
                        vm.end()
                    } label: {
                        ButtonView(label: "Reset")
                    }
                }
            }
            
            // End button
            if vm.inFocus {
                if vm.timerPaused && vm.focusTimeRemaining > 0 {
                    Button {
                        vm.restartTimer()
                    } label: {
                        ButtonView(label: "End", selectSmallerSize: true)
                    }
                }
            } else if vm.inFlow {
                if vm.timerPaused && vm.flowTimeRemaining > 0 {
                    Button {
                        vm.end()
                    } label: {
                        ButtonView(label: "End", selectSmallerSize: true)
                    }
                }
            } else if vm.inBreak {
                if vm.timerPaused && vm.breakTimeRemaining > 0 {
                    Button {
                        taskSelected?.totalTimeStudied += timeStudied
                        try? moc.save()
                        vm.end()
                    } label: {
                        ButtonView(label: "End", selectSmallerSize: true)
                    }
                }
            }
        }
        .font(.headline.bold())
        .shadow(radius: 1)
        .disabled(showEditTimerPopupView)
    }
    
    func userNotification() {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Flowdoro"
            //content.subtitle = "subtitle"
            content.body = "Timer finished!"
            content.sound = !vm.inFlow ? UNNotificationSound.default : UNNotificationSound(named: UNNotificationSoundName(rawValue: "notification0.mp3"))
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: (vm.inFocus ? vm.focusTimeRemaining : (vm.inFlow ? vm.flowTimeRemaining - 0.05 : vm.breakTimeRemaining)), repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
                UNUserNotificationCenter.current().delegate = delegate
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                        UNUserNotificationCenter.current().delegate = delegate
                    } else {
                        print("bet")
                    }
                }
            }
        }
    }
    
    class NotificationDelegate: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([.badge, .banner, .sound])
        }
    }
    
    //    private var breakButton: some View  {
    //        VStack {
    //            if inBreak {
    //                if vm.timerPaused && vm.breakTimeRemaining > 0 {
    //                    Button {
    //                        vm.startTimer()
    //                    } label: {
    //                        ButtonView(label: "Break")
    //                    }
    //                } else if !vm.timerPaused && vm.focusTimeRemaining > 0 {
    //                    Button {
    //                        vm.pauseTimer()
    //                    } label: {
    //                        ButtonView(label: "Pause")
    //                    }
    //                } else if vm.focusTimeRemaining == 0 {
    //                    inFocus = true
    //                }
    //            } else {
    //                Text("hi")
    //            }
    //        }
    //    }
    
    //    func inverse() -> Int {
    //        if vm.focusTime == vm.focusTimeRemaining {
    //            vm.counter = 0
    //        } else if vm.counter <= Int(vm.focusTime) - 1 {
    //            vm.counter += 1
    //        }
    //        return vm.counter
    //    }
}
