//
//  TabBarShadow.swift
//  Flexodoro
//
//  Created by Bruke on 4/18/23.
//

import SwiftUI

struct TabBarShadow: View {
    var body: some View {
        tabBarShadow
    }
}

struct TabBarShadow_Previews: PreviewProvider {
    static var previews: some View {
        TabBarShadow()
    }
}

extension TabBarShadow {
    private var tabBarShadow: some View {
        Rectangle()
            .fill(.gray)
            .opacity(0.5)
            .frame(height: 0.55)
            .frame(maxHeight: .infinity, alignment: .bottom)
    }
}
