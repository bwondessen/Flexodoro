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
    @StateObject private var delegate = NotificationDelegate()
    
    @State private var showEditTimerPopupView: Bool = false
    
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
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        VStack {
                            Text("Flow")
                            Text(vm.flowTime.asNumberString())
                        }
                        .onTapGesture {
                            vm.focusSelected = false
                            vm.flowSelected = true
                            vm.breakSelected = false
                            showEditTimerPopupView = true
                        }
                        VStack {
                            Text("Focus")
                            Text(vm.focusTime.asNumberString())
                        }
                        .onTapGesture {
                            vm.focusSelected = true
                            vm.flowSelected = false
                            vm.breakSelected = false
                            showEditTimerPopupView = true
                        }
                        VStack {
                            Text("Break")
                            Text(vm.breakTime.asNumberString())
                        }
                        .onTapGesture {
                            vm.focusSelected = false
                            vm.flowSelected = false
                            vm.breakSelected = true
                            showEditTimerPopupView = true
                        }
                    }
                    
                    Text("total time: \(totalTimeStudied)")
//                    Group {
//                        Text("focus time: \(vm.focusTime)")
//                        Text("focus time remaining: \(vm.focusTimeRemaining)")
//                        Text("flow time: \(vm.flowTime)")
//                        Text("flow time remaining: \(vm.flowTimeRemaining)")
//                        Text("break time: \(vm.breakTime)")
//                        Text("break time remaining: \(vm.breakTimeRemaining)")
//                        Text("counter: \(vm.counter)")
//                        Text("total cycles: \(vm.totalCycles)")
//                        ScrollView {
//                        ForEach(stats) { stat in
//                            Text("betski: \(stat.timeStudied)")
//                        }
//                        }
//                        .frame(height: 55)
//                    }
                    
                    timerView
                    
                    HStack {
                        focusButton
                    }
                    .onChange(of: vm.breakTimeRemaining) { _ in
                        if vm.breakTimeRemaining == 0 {
                            //vm.resetCycle()
                            vm.totalCycles += 1
                        }
                    }
                    
                    TabBarShadow()
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
                .navigationTitle("Flexodoro")
                .onAppear(perform: vm.pauseTimer)
                //            .overlay(
                //                EditTimeView(timeSelected: $timeSelected)
                //            )
                EditTimerPopupView(showEditTimerPopupView: $showEditTimerPopupView)
            }
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
        Circle()
            .stroke(Color.theme.buttonBackground, lineWidth: 15)
            .frame(width: UIScreen.main.bounds.width * 0.80, height: UIScreen.main.bounds.height * 0.45)
            .overlay(
                ZStack {
                    Circle()
                        .trim(from: 0, to: vm.timeRemainingInPercent())
                        .stroke(Color.theme.accent, lineWidth: 15)
                        .rotationEffect(.degrees(-90))
                    Text(vm.inFocus ? "\(vm.focusTimeRemaining.asNumberString())" : (vm.inFlow ? "\(vm.flowTimeRemaining.asNumberString())" : "\(vm.breakTimeRemaining.asNumberString())"))
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
                        DataController().addStats(timeStudied: timeStudied, totalTimeStudied: totalTimeStudied, context: moc)
                        //vm.skip()
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
                            DataController().addStats(timeStudied: timeStudied, totalTimeStudied: totalTimeStudied, context: moc)
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
                        vm.end()
                    } label: {
                        ButtonView(label: "End", selectSmallerSize: true)
                    }
                }
            }
        }
    }
    
    func userNotification() {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "title"
            content.subtitle = "subtitle"
            content.body = "body"
            content.sound = UNNotificationSound.default
            
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
