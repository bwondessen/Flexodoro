//
//  ButtonView.swift
//  Flowdoro
//
//  Created by Bruke on 10/24/22.
//

import SwiftUI

struct ButtonView: View {
    let label: String
    let selectSmallerSize: Bool
    
    init(label: String, selectSmallerSize: Bool = false) {
        self.label = label
        self.selectSmallerSize = selectSmallerSize
    }
    
    var body: some View {
        Circle()
            .fill(Color.theme.accent)
            .overlay(
                Text(label)
                    .foregroundColor(.white)
            )
            .frame(width: selectSmallerSize ? 80 : 120, height: selectSmallerSize ? 80 : 120)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(label: "Button")
    }
}
