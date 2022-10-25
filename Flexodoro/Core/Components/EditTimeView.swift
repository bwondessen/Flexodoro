//
//  EditTimeView.swift
//  Flexodoro
//
//  Created by Bruke on 10/25/22.
//

import SwiftUI

struct EditTimeView: View {
    @Binding var timeSelected: Double
    
    var body: some View {
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
                            .fill(Color.gray.opacity(0.15))
                    )
                    .onTapGesture {
                        timeSelected = 15
                    }
                Spacer()
                Text("30:00")
                    .padding(5)
                    .background(
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color.gray.opacity(0.15))
                    )
                    .onTapGesture {
                        timeSelected = 30
                    }
                Spacer()
                Text("45:00")
                    .padding(5)
                    .background(
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color.gray.opacity(0.15))
                    )
                    .onTapGesture {
                        timeSelected = 45
                    }
                Spacer()
            }
            .font(.subheadline)
            
            Spacer()
            
            Text("Custom")
                .font(.footnote)
                .padding(5)
                .background(
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color.gray.opacity(0.15))
                )
                .onTapGesture {
                    Picker("Custom", selection: $timeSelected) {
                        ForEach(1..<100) { num in
                            Text("\(num)")
                        }
                    }
                }
            
            Spacer()
            
            HStack {
                Button {
                    
                } label: {
                    Text("Cancel")
                        .font(.footnote)
                        .padding(5)
                        .background(
                            RoundedRectangle(cornerRadius: 3)
                                .fill(Color.gray.opacity(0.15))
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
                                .fill(Color.gray.opacity(0.15))
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

struct EditTimeView_Previews: PreviewProvider {
    static var previews: some View {
        EditTimeView(timeSelected: .constant(60))
    }
}
