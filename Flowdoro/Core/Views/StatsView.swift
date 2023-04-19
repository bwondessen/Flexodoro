//
//  StatsView.swift
//  Flexodoro
//
//  Created by Bruke on 4/18/23.
//

import SwiftUI
import CoreData

struct StatsView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var stats: FetchedResults<Stats>
    
    var totalTimeStudied: Double {
        var totalTime: Double = 0
        for stat in stats {
            totalTime += stat.timeStudied
        }
        
        return totalTime
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Total Study Time")
                        .font(.title.bold())
                    Text("\(totalTimeStudied)")
                }
            }
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
