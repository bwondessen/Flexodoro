//
//  InfoView.swift
//  Flexodoro
//
//  Created by Bruke on 5/2/23.
//

import SwiftUI

struct InfoView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let emailURL = URL(string: "mailto:bwondessen23@gmail.com")!
    let twitterURL = URL(string: "https://www.twitter.com/bwondessen")!
    let githubURL = URL(string: "https://github.com/bwondessen")!
    let coinGeckoURL = URL(string: "https://www.coingecko.com")!
    let defaultURL = URL(string: "https://www.gogle.com")!
    
    var body: some View {
        ZStack {
            // background layer
            //Color.blue
                //.ignoresSafeArea()
            
            // content layer
            List {
                develperSection
                    //.listRowBackground(Color.blue.opacity(0.5))
                //applicationSection
                    //.listRowBackground(Color.blue.opacity(0.5))
            }
            .listStyle(.plain)
        }
        .navigationBarTitleDisplayMode(.inline)
        .font(.headline)
        .tint(.blue)
        .navigationTitle("Info")
        //            .toolbar {
        //                ToolbarItem(placement: .navigationBarLeading) {
        //                    Button {
        //                        dismiss()
        //                    } label: {
        //                        Image(systemName: "xmark")
        //                    }
        //                }
        //            }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}

extension InfoView {
    private var develperSection: some View {
        Section {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Image("logo-white")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                    Spacer()
                }
                Text("Flowdoro is a flexible and intuitive pomodoro timer. Regular pomodoros set a rigid time limit that interrupt you durring your flow state, limitting your productivity. Where Flowdoro differs is that it allows you to set two timers: the focus and flow timer. The focus timer is the main timer you expect to get things done. While the flow timer is the additional time added to let you finish up what you are currently on. The concept is to allow you to get the most out of your sessions by allowing you to finish up that chapter, wrap up that assignmet, etc. The sky is the limit!")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.blue)
            }
            .padding(.vertical)
            .listRowSeparator(.hidden)
            //Link("👨‍💻 Contact Developer", destination: emailURL)
            //Link("My Twitter 📱", destination: twitterURL)
            //Link("My Github 👾", destination: githubURL)
        }
    }
    
//    private var applicationSection: some View {
//        Section(header: Text("Application").listRowSeparator(.hidden)) {
//            NavigationLink("Terms of Conditions") {
//                TermsOfConditionsView(htmlString: TermsOfConditionsHTML.terms)
//                    .navigationBarTitle("Terms of Conditions")
//                    .navigationBarTitleDisplayMode(.inline)
//            }
//            NavigationLink("Privacy Policy") {
//                PrivacyPolicyView(htmlString: PrivacyPolicyHTML.policy)
//                    .navigationBarTitle("Privacy Policy")
//                    .navigationBarTitleDisplayMode(.inline)
//            }
//            //Link("Terms of Service", destination: defaultURL)
//            //Link("Privacy Policy", destination: defaultURL)
//            //Link("Company Website", destination: defaultURL)
//            //Link("Learn more", destination: defaultURL)
//        }
//    }
}
