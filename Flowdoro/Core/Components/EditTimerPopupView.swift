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
        ZStack(alignment: .top) {
            Color.clear.ignoresSafeArea()
            
            if showEditTimerPopupView {
                VStack(spacing: 5) {
                    Text("Select a duration")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
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
                                selectedTime = 15
                                buttonOneTapped = true
                                buttonTwoTapped = false
                                buttonThreeTapped = false
                            }
                        Spacer()
                        Text("30:00")
                            .padding()
                            .foregroundColor(buttonTwoTapped ? .white : .primary)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(buttonTwoTapped ? Color.theme.accent : Color.theme.buttonBackground)
                            )
                            .onTapGesture {
                                selectedTime = 30
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
                                selectedTime = 45
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
                                Spacer()
                                Text("\(selectedTime)")
                                    .font(.subheadline.bold())
                            }
                            Slider(value: $selectedTime, in: 1...100)
                                .onChange(of: selectedTime) { newValue in
                                    if selectedTime != 15 && selectedTime != 30 && selectedTime != 45 {
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
                }
                .padding()
                .padding(.bottom)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.30)
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
        }
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
            vm.focusTime = selectedTime
            vm.focusTimeRemaining = selectedTime
        } else if vm.flowSelected {
            vm.flowTime = selectedTime
            vm.flowTimeRemaining = selectedTime
        } else if vm.breakSelected {
            vm.breakTime = selectedTime
            vm.breakTimeRemaining = selectedTime
        }
    }
}
