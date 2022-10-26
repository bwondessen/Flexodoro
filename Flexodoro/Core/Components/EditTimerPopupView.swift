//
//  EditTimeView.swift
//  Flexodoro
//
//  Created by Bruke on 10/25/22.
//

import SwiftUI

struct EditTimerPopupView: View {
    @Binding var showEditTimerPopupView: Bool
    
    @Binding var timeSelected: Double
    @State private var showPicker: Bool = false
    
    var body: some View {
        ZStack {
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
                            .background(
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(Color.theme.buttonBackground)
                            )
                            .onTapGesture {
                                timeSelected = 15
                            }
                        Spacer()
                        Text("30:00")
                            .padding(5)
                            .background(
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(Color.theme.buttonBackground)
                            )
                            .onTapGesture {
                                timeSelected = 30
                            }
                        Spacer()
                        Text("45:00")
                            .padding(5)
                            .background(
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(Color.theme.buttonBackground)
                            )
                            .onTapGesture {
                                timeSelected = 45
                            }
                        Spacer()
                    }
                    .font(.subheadline)
                    
                    Spacer()
                    
                    VStack {
                        Text("Custom")
                            .font(.footnote)
                            .padding(5)
                            .background(
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(Color.theme.buttonBackground)
                            )
                        if showPicker {
                            HStack {
                                ForEach(1..<11) { num in
                                    Spacer()
                                    Text("\(num)")
                                        .font(.subheadline)
                                        .onTapGesture {
                                            timeSelected = Double(num)
                                        }
                                    Spacer()
                                }
                            }
                        }
                    }
                    .onTapGesture {
                        showPicker = true
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button {
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
                .frame(width: UIScreen.main.bounds.width * 0.75, height: UIScreen.main.bounds.height * 0.30)
                .background(
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color.white)
                        .shadow(radius: 2.5)
                )
            }
        }
    }
}

struct EditTimeView_Previews: PreviewProvider {
    static var previews: some View {
        EditTimerPopupView(showEditTimerPopupView: .constant(false), timeSelected: .constant(60))
    }
}

extension EditTimerPopupView {
    private var pickerView: some View {
        Picker("Time", selection: $timeSelected) {
            ForEach(0..<30) { num in
                Text("\(num)")
            }
        }
    }
}
