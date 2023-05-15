//
//  EditTimeView.swift
//  Flowdoro
//
//  Created by Bruke on 10/25/22.
//

import SwiftUI

struct EditTimerPopupView: View {
    @EnvironmentObject private var vm: HomeViewModel
    
    @Binding var showEditTimerPopupView: Bool
    @State private var selectedTime: Double = 5
    @State private var pickerNumber: Double = 5
    
    @State private var buttonOneTapped: Bool = false
    @State private var buttonTwoTapped: Bool = false
    @State private var buttonThreeTapped: Bool = false
    @State private var customButtonTapped: Bool = false
    
    var body: some View {
//        ZStack(alignment: .top) {
//            Color.clear.ignoresSafeArea()
            
            if showEditTimerPopupView {
                VStack(spacing: 5) {
                    Spacer()
                    Text("Select a duration")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.top)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Text("15:00")
                            .padding()
                            .foregroundColor(buttonOneTapped ? .white : .primary)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(buttonOneTapped ? Color.theme.accent : Color.theme.buttonBackground)
                            )
                            .onTapGesture {
                                selectedTime = 900
                                buttonOneTapped = true
                                buttonTwoTapped = false
                                buttonThreeTapped = false
                            }
                        Spacer()
                        Text("25:00")
                            .padding()
                            .foregroundColor(buttonTwoTapped ? .white : .primary)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(buttonTwoTapped ? Color.theme.accent : Color.theme.buttonBackground)
                            )
                            .onTapGesture {
                                selectedTime = 1500
                                buttonOneTapped = false
                                buttonTwoTapped = true
                                buttonThreeTapped = false
                            }
                        Spacer()
                        Text("45:00")
                            .padding()
                            .foregroundColor(buttonThreeTapped ? .white : .primary)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(buttonThreeTapped ? Color.theme.accent : Color.theme.buttonBackground)
                            )
                            .onTapGesture {
                                selectedTime = 2700
                                buttonOneTapped = false
                                buttonTwoTapped = false
                                buttonThreeTapped = true
                            }
                        Spacer()
                    }
                    .font(.subheadline)
                    
                    Spacer()
                    
                    VStack {
//                        Text("Custom")
//                            .font(.footnote)
//                            .foregroundColor(customButtonTapped ? .white : .primary)
//                            .padding()
//                            .background(
//                                RoundedRectangle(cornerRadius: 10)
//                                    .fill(customButtonTapped ? Color.theme.accent : Color.theme.buttonBackground)
//                            )
                        VStack {
                            HStack {
                                //Text(printSecondsToHoursMinutesSeconds(Int(selectedTime)))
                                Text(selectedTime.asString(style: .full))
                                    .font(.title)
                                    .fontWeight(.semibold)
                            }
                            Slider(value: $selectedTime, in: 5...10800, step: 60)
                                .padding()
                                .onChange(of: selectedTime) { newValue in
                                    if selectedTime != 900 && selectedTime != 1500 && selectedTime != 2700 {
                                        buttonOneTapped = false
                                        buttonTwoTapped = false
                                        buttonThreeTapped = false
                                    }
                                }
                        }
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button {
                            buttonOneTapped = false
                            buttonTwoTapped = false
                            buttonThreeTapped = false
                            selectedTime = 300
                            showEditTimerPopupView = false
                        } label: {
                            Text("Cancel")
                                .font(.footnote)
                                .fontWeight(.heavy)
                                .padding()
                                .padding(.horizontal)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.theme.buttonBackground)
                                )
                        }
                        .padding(.trailing)
                        
                        Button {
                            buttonOneTapped = false
                            buttonTwoTapped = false
                            buttonThreeTapped = false
                            editTimer()
                            selectedTime = 300
                            showEditTimerPopupView = false
                        } label: {
                            Text("Confirm")
                                .font(.footnote)
                                .fontWeight(.heavy)
                                .padding()
                                .padding(.horizontal)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.theme.buttonBackground)
                                )
                        }
                    }
                    .padding(.bottom)
                    //Spacer()
                }
//                .padding()
//                .padding(.bottom)
//                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.30)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(color: .gray, radius: 3.5, x: 0, y: 7.5)
                )
                //                .overlay(
                //                    showPicker ?
                //                    VStack {
                //                        RoundedRectangle(cornerRadius: 20)
                //                            .fill(.white)
                //                        VStack {
                //                            Group {
                //                            //Text("Select a duration")
                //                                Text("selected time: \(selectedTime)")
                //                                .font(.title3)
                //                                .fontWeight(.semibold)
                //
                //                            Picker("picker", selection: $selectedTime) {
                //                                ForEach(1...100, id: \.self) { num in
                //                                    Text("\(num)")
                //                                }
                //                            }
                //                            .pickerStyle(.wheel)
                //                            }
                //                            HStack {
                //                                Button {
                //                                    buttonOneTapped = false
                //                                    buttonTwoTapped = false
                //                                    buttonThreeTapped = false
                //                                    customButtonTapped = false
                //                                    //showEditTimerPopupView = false
                //                                    showPicker = false
                //                                } label: {
                //                                    Text("Cancel")
                //                                        .font(.footnote)
                //                                        .padding()
                //                                        .padding(.horizontal)
                //                                        .background(
                //                                            RoundedRectangle(cornerRadius: 10)
                //                                                .fill(Color.theme.buttonBackground)
                //                                        )
                //                                }
                //                                .padding(.trailing)
                //
                //                                Button {
                //                                    buttonOneTapped = false
                //                                    buttonTwoTapped = false
                //                                    buttonThreeTapped = false
                //                                    customButtonTapped = false
                //                                    editTimer()
                //                                    //selectedTime = 50
                //                                    showEditTimerPopupView = false
                //                                    showPicker = false
                //                                } label: {
                //                                    Text("Confirm")
                //                                        .font(.footnote)
                //                                        .padding()
                //                                        .padding(.horizontal)
                //                                        .background(
                //                                            RoundedRectangle(cornerRadius: 10)
                //                                                .fill(Color.theme.buttonBackground)
                //                                        )
                //                                }
                //                            }
                //                        }
                //                        .padding()
                //                        .background(
                //                            RoundedRectangle(cornerRadius: 20)
                //                                .fill(Color.white)
                //                                .shadow(color: .gray, radius: 3.5, x: 0, y: 7.5)
                //                        )
                //                    }
                //                    :
                //                        nil
                //                )
                //.animation(.default)
            }
        //}
    }
    
    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return ((seconds * 60) / 3600, ((seconds * 60) % 3600) / 60, (seconds % 3600) % 60)
//        return (Int(minutes) / 60, (Int(minutes) % 60), (Int(minutes) % 60) * 60)
        
//        return (Int(minutes) / 60, (Int(minutes) % 60), Int((minutes.truncatingRemainder(dividingBy: 60) % Int(minutes) % 60)))
    }
    
    func printSecondsToHoursMinutesSeconds(_ seconds: Int) -> String {
        //let time = seconds * 60
      let (h, m, s) = secondsToHoursMinutesSeconds(seconds)
        //return ("\(h) Hours, \(m) Minutes, \(s) Seconds")
        return ("\(h)hr  \(m)min \(s)sec")
    }
}

//struct EditTimeView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditTimerPopupView(showEditTimerPopupView: .constant(false))
//    }
//}

extension EditTimerPopupView {
    private var pickerView: some View {
        Picker("Time", selection: $vm.focusTime) {
            ForEach(0..<30) { num in
                Text("\(num)")
            }
        }
    }
    
    func editTimer() {
        if vm.focusSelected {
            vm.focusTime = Double(selectedTime)
            vm.focusTimeRemaining = Double(selectedTime)
        } else if vm.flowSelected {
            vm.flowTime = Double(selectedTime)
            vm.flowTimeRemaining = Double(selectedTime)
        } else if vm.breakSelected {
            vm.breakTime = Double(selectedTime)
            vm.breakTimeRemaining = Double(selectedTime)
        }
        
        vm.restartTimer()
    }
}
