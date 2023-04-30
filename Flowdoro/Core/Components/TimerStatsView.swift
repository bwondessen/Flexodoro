//
//  TimerStatsView.swift
//  Flexodoro
//
//  Created by Bruke on 4/29/23.
//

import SwiftUI

struct TimerStatsView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Text(title)
                .font(.body)
                .foregroundColor(Color.gray)
            Text(value)
                .font(.headline.bold())
        }
        .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.height * 0.05)
        .padding()
//        .background {
//            RoundedRectangle(cornerRadius: 10)
//                .stroke(.black, lineWidth: 0.5)
//        }
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .shadow(radius: 2.5)
        }
    }
}

//struct TimerStatsView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimerStatsView()
//    }
//}
