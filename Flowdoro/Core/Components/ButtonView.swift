//
//  ButtonView.swift
//  Flowdoro
//
//  Created by Bruke on 10/24/22.
//

import SwiftUI

struct ButtonView: View {
    let label: String
    
    var body: some View {
        Circle()
            .fill(Color.theme.accent)
            .overlay(
                Text(label)
                    .foregroundColor(.white)
            )
            .frame(width: 120, height: 120)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(label: "Button")
    }
}
