////
////  Login.swift
////  Flexodoro
////
////  Created by Bruke on 5/1/23.
////
//
//import SwiftUI
////import Firebase
//
//struct Login: View {
//    @EnvironmentObject private var vm: HomeViewModel
//
//    @State private var enteredUserName: String = ""
//    @State private var enteredPassword: String = ""
//
//    @AppStorage("userName") var userName: String = ""
//    @AppStorage("password") var password: String = ""
//
//    var body: some View {
//        VStack {
//            bryptoHeader
//            //Text("username: \(userName)")
//            //Text("password: \(password)")
//            login
//            //faceIDSection
//            loginButton
//                .disabled(!aunthenticateLogin())
//                .opacity(!aunthenticateLogin() ? 0.75 : 1)
//            //orDivider
//            signUpMessage
//        }
//        .navigationBarHidden(true)
//        .navigationBarBackButtonHidden(true)
////        .onAppear {
////            Auth.auth().addStateDidChangeListener { auth, user in
////                if user != nil {
////                    vm.isLoggedIn.toggle()
////                }
////            }
////        }
////        .background(
////            Rectangle()
////                .fill(.white)
////                .cornerRadius(5)
////                .shadow(radius: 5)
////        )
////        .padding()
//    }
//}
//
//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        Login()
//    }
//}
//
//extension Login {
//    var bryptoHeader: some View {
//        VStack {
//            Image("logo-white")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 150, height: 150)
////            Text("Brypto!")
////                //.font(.largeTitle.bold())
////                .font(.system(<#T##style: Font.TextStyle##Font.TextStyle#>, design: <#T##Font.Design#>))
////                .foregroundColor(Color.theme.accentMain)
//        }
//    }
//
//    var login: some View {
//        VStack {
//            Group {
//                TextField("Username", text: $enteredUserName)
//                SecureField("Password", text: $enteredPassword)
//            }
//            .disableAutocorrection(true)
//            .padding()
//            .overlay(
//                RoundedRectangle(cornerRadius: 5)
//                //.fill(.clear)
//                    .stroke(Color.secondary, style: StrokeStyle(lineWidth: 2))
//            )
//            .padding()
//        }
//    }
//
////    var faceIDSection: some View {
////        Button {
////            vm.authenticate()
////        } label: {
////            HStack {
////                // remember section
////
////                HStack(spacing: 3) {
////                    Image(systemName: "faceid")
////                    Text("Use Face ID")
////                        .font(.headline)
////                }
////                .foregroundColor(.blue)
////            }
////        }
////
////    }
//
////    var loginButton: some View {
////        Button {
////            //vm.login(enteredUserName: enteredUserName, enteredPassword: enteredPassword)
////            vm.login(enteredUserName: enteredUserName, enteredPassword: enteredPassword)
////        } label: {
////            Text("Login")
////                .font(.headline.bold())
////                .foregroundColor(.white)
////                .padding()
////                .frame(maxWidth: .infinity)
////                .background(.blue)
////                .cornerRadius(10)
////                .padding()
////        }
////    }
//
//
//
//    var orDivider: some View {
//        HStack {
//            Rectangle()
//                .frame(maxWidth: .infinity)
//                .frame(height: 0.5)
//                .foregroundColor(Color.secondary)
//            Text("OR")
//            Rectangle()
//                .frame(maxWidth: .infinity)
//                .frame(height: 0.5)
//                .foregroundColor(Color.secondary)
//        }
//        .padding()
//    }
//
//    var signUpMessage: some View {
////        NavigationLink {
////            SignUpView()
////                .navigationBarBackButtonHidden(true)
////        } label: {
////            Text("Sign up")
////                .font(.headline.bold())
////                .foregroundColor(Color("LaunchAccentColor"))
////                .padding()
////                .frame(maxWidth: .infinity)
////                .background(.black)
////                .cornerRadius(10)
////                .padding()
////        }
//
//        HStack {
//            Text("Don't have an account?")
//                .font(.subheadline.bold())
//                //.foregroundColor(Color.theme.secondaryText)
//            NavigationLink {
//                SignUp()
//            } label: {
//                Text("Create a new one")
//                    .font(.subheadline.bold())
//                    .foregroundColor(.blue)
//            }
//        }
//        .padding()
//    }
//
//    func aunthenticateLogin() -> Bool {
//        if !enteredUserName.isEmpty && !enteredPassword.isEmpty {
//            return true
//        } else {
//            return false
//        }
//    }
//}
//
