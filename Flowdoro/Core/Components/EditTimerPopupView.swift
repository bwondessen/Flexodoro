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
    @State private var showPicker: Bool = false
    @State private var selectedTime: Double = 0
    
    @State private var buttonOneTapped: Bool = false
    @State private var buttonTwoTapped: Bool = false
    @State private var buttonThreeTapped: Bool = false
    @State private var customButtonTapped: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.clear.ignoresSafeArea()
            
            if showEditTimerPopupView {
                VStack(spacing: 20) {
                    Text("Select a duration")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Text("15:00")
                            .padding(5)
                            .foregroundColor(buttonOneTapped ? .white : .primary)
                            .background(
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(buttonOneTapped ? Color.theme.accent : Color.theme.buttonBackground)
                            )
                            .onTapGesture {
                                selectedTime = 15
                                buttonOneTapped = true
                                buttonTwoTapped = false
                                buttonThreeTapped = false
                                customButtonTapped = false
                            }
                        Spacer()
                        Text("30:00")
                            .padding(5)
                            .foregroundColor(buttonTwoTapped ? .white : .primary)
                            .background(
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(buttonTwoTapped ? Color.theme.accent : Color.theme.buttonBackground)
                            )
                            .onTapGesture {
                                selectedTime = 30
                                buttonOneTapped = false
                                buttonTwoTapped = true
                                buttonThreeTapped = false
                                customButtonTapped = false
                            }
                        Spacer()
                        Text("45:00")
                            .padding(5)
                            .foregroundColor(buttonThreeTapped ? .white : .primary)
                            .background(
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(buttonThreeTapped ? Color.theme.accent : Color.theme.buttonBackground)
                            )
                            .onTapGesture {
                                selectedTime = 45
                                buttonOneTapped = false
                                buttonTwoTapped = false
                                buttonThreeTapped = true
                                customButtonTapped = false
                            }
                        Spacer()
                    }
                    .font(.subheadline)
                    
                    Spacer()
                    
                    VStack {
                        Text("Custom")
                            .font(.footnote)
                            .foregroundColor(customButtonTapped ? .white : .primary)
                            .padding(5)
                            .background(
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(customButtonTapped ? Color.theme.accent : Color.theme.buttonBackground)
                            )
                        if showPicker {
                            HStack {
                                ForEach(1..<11) { num in
                                    Spacer()
                                    Text("\(num)")
                                        .font(.subheadline)
                                        .onTapGesture {
                                            selectedTime = Double(num)
                                        }
                                    Spacer()
                                }
                            }
                        }
                    }
                    .onTapGesture {
                        showPicker = true
                        buttonOneTapped = false
                        buttonTwoTapped = false
                        buttonThreeTapped = false
                        customButtonTapped = true
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button {
                            buttonOneTapped = false
                            buttonTwoTapped = false
                            buttonThreeTapped = false
                            customButtonTapped = false
                            showEditTimerPopupView = false
                        } label: {
                            Text("Cancel")
                                .font(.footnote)
                                .padding(5)
                                .background(
                                    RoundedRectangle(cornerRadius: 3)
                                        .fill(Color.theme.buttonBackground)
                                )
                        }
                        .padding(.trailing)
                        
                        Button {
                            buttonOneTapped = false
                            buttonTwoTapped = false
                            buttonThreeTapped = false
                            customButtonTapped = false
                            editTimer()
                            showEditTimerPopupView = false
                        } label: {
                            Text("Confirm")
                                .font(.footnote)
                                .padding(3)
                                .background(
                                    RoundedRectangle(cornerRadius: 3)
                                        .fill(Color.theme.buttonBackground)
                                )
                        }
                    }
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.30)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(color: .gray, radius: 3.5, x: 0, y: 7.5)
                )
                .animation(.default)
            }
        }
    }
}

struct EditTimeView_Previews: PreviewProvider {
    static var previews: some View {
        EditTimerPopupView(showEditTimerPopupView: .constant(false))
    }
}

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
