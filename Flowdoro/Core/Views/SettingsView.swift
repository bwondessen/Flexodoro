//
//  SettingsView.swift
//  Flexodoro
//
//  Created by Bruke on 5/2/23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @Environment(\.dismiss) var dismiss
    //@State var alternativeTheme: Bool
    
    @State private var taskName: String = ""
    @State private var taskColor: Color? = nil
    @State private var taskCreated: Bool = false
    
    @State private var showLogOutAlert: Bool = false
    
    @State private var includeXMark: Bool = false
    
    @AppStorage("faceIDEnabled") private var faceIDEnabled: Bool = false
    @AppStorage("passcodeRequired") var passcodeRequired: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    infoSection
                }
                
                Section {
                    createTaskSection
                }
                
                
//                Section {
//                    accountSection
//                }
                
//                Section {
//                    securitySection
//                }
                
//                Section {
//                    logOutSection
//                        .listRowBackground(Color.clear)
//                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.insetGrouped)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .tint(.black)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
//        .alert("Confirm log out", isPresented: $showLogOutAlert) {
//            Button("Cancel", role: .cancel) { }
//            Button("Log out", role: .destructive) {
//                vm.logOut()
//                dismiss()
//            }
//        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension SettingsView {
    private var infoSection: some View {
        NavigationLink {
            InfoView()
        } label: {
            HStack {
                Image(systemName: "info.circle")
                VStack(alignment: .leading) {
                    Text("Info")
                        .font(.headline)
                    //Text("About, contact, terms of service")
                    Text("About")
                        .font(.footnote.italic())
                }
            }
        }
    }
    
    private var createTaskSection: some View {
        NavigationLink {
            CreateTaskView(taskName: $taskName, taskColor: $taskColor, taskCreated: $taskCreated, includeXMark: $includeXMark)
        } label: {
            HStack {
                Image(systemName: "pencil")
                VStack(alignment: .leading) {
                    Text("Create task")
                        .font(.headline)
//                    Text("Create task")
//                        .font(.footnote.italic())
                }
            }
        }
    }
    
//    private var accountSection: some View {
//        NavigationLink {
//            EditAccountView()
//        } label: {
//            HStack {
//                Image(systemName: "person.crop.circle")
//                VStack(alignment: .leading) {
//                    Text("Account")
//                        .font(.headline)
//                    Text("Change password & username")
//                        .font(.footnote.italic())
//                }
//            }
//        }
//    }
        
//    private var themeSection: some View {
//        Toggle("Alternative Theme", isOn: $vm.alternativeTheme)
//            .accentColor(Color.theme.accentMain)
//    }
    
    private var logOutSection: some View {
        Button {
            showLogOutAlert = true
        } label: {
            Text("Log out")
                .font(.headline.bold())
                .foregroundColor(Color.blue)
                .padding()
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color.blue, lineWidth: 0.55)
                )
        }
    }
}
