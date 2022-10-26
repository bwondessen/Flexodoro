//
//  ButtonView.swift
//  Flexodoro
//
//  Created by Bruke on 10/24/22.
//

import SwiftUI

struct ButtonView: View {
    let label: String
    
    var body: some View {
        Text(label)
            .font(.headline.bold())
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.theme.accent)
            .cornerRadius(10)
            .padding(.horizontal)
    }
}

//struct ButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        ButtonView(label: "Button", action: () -> ())
//    }
//}
