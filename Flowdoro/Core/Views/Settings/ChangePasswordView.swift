////
////  ChangePasswordView.swift
////  Flexodoro
////
////  Created by Bruke on 5/2/23.
////
//
//import SwiftUI
//
//struct ChangePasswordView: View {
//    @State private var newPassword: String = ""
//    @State private var oldPassowrd: String = ""
//
//    @AppStorage("passwrd") var password: String = ""
//    
//    var body: some View {
//        VStack {
//            List {
//                Section("Enter old password") {
//                    SecureField("Old password", text: $oldPassowrd)
//                        .textFieldStyle(.roundedBorder)
//                        .listRowBackground(Color.clear)
//                }
//
//                Section("Enter new password") {
//                    SecureField("New Passowrd", text: $newPassword)
//                        .textFieldStyle(.roundedBorder)
//                        .disabled(!passwordCheck())
//                        .listRowBackground(Color.clear)
//                }
//
//                Section {
//                    Button {
//                        password = newPassword
//                    } label: {
//                        Text("Confirm")
//                            .font(.headline.bold())
//                            .foregroundColor(.white)
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(Color.blue)
//                            .cornerRadius(10)
//                            .padding()
//                    }
//                    .disableAutocorrection(!passwordCheck())
//                    .disabled(!passwordCheck())
//                    .listRowBackground(Color.clear)
//                }
//            }
//        }
//        .navigationBarTitle("Change password")
//        .navigationBarTitleDisplayMode(.inline)
//    }
//}
//
//struct ChangePasswordView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChangePasswordView()
//    }
//}
//
//extension ChangePasswordView {
//    func passwordCheck() -> Bool {
//        if oldPassowrd == password {
//            return true
//        } else {
//            return false
//        }
//    }
//}
