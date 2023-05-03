//
//  SignUp.swift
//  Flexodoro
//
//  Created by Bruke on 5/1/23.
//

import SwiftUI
import Firebase

struct SignUp: View {
    @EnvironmentObject private var vm: HomeViewModel
    
    @State private var enteredName: String = ""
    @State private var enteredUserName: String = "".lowercased()
    @State private var enteredPassword: String = ""
    @State private var enteredEmail: String = ""
    
    @AppStorage("fullName") var fullName: String = ""
    //@AppStorage("firstName") private var firstName: String
    //@AppStorage("lastName") private var lastName: String
    @AppStorage("userName") var userName: String = ""
    @AppStorage("password") var password: String = ""
    @AppStorage("email") var email: String = ""
        
    var body: some View {
        //NavigationView {
        VStack {
            welcomeSection
            loginInfo
            signUpButton
                .disabled(aunthenticateSignUp())
                .opacity(aunthenticateSignUp() ? 0.75 : 1)
            //orDivider
            loginMessage
        }
        .navigationBarHidden(true)
//        .background(
//            Rectangle()
//                .fill(.white)
//                .cornerRadius(5)
//                .shadow(radius: 5)
//        )
//        .padding()
//        .padding()
        //}
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}

extension SignUp {
    var welcomeSection: some View {
        VStack {
            Image("logo-white")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
//            Text("Welcome to Brypto!")
//                .font(.largeTitle.bold())
//                .foregroundColor(Color.theme.accentMain)
//            Text("Sign up to stay up to date with all things crypto.")
//                .foregroundColor(Color.secondary)
//                .font(.headline)
//                .fixedSize(horizontal: false, vertical: true)
//                .multilineTextAlignment(.center)
        }
        .padding(.horizontal)
    }
    
    var loginInfo: some View {
        VStack(spacing: -20) {
            Group {
                TextField("Name", text: $enteredName)
                TextField("Email", text: $enteredEmail)
                //DatePicker("Birthday 🎂", selection: $birthday, in: ...Date(), displayedComponents: [.date])
                TextField("Username", text: $enteredUserName)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                SecureField("Password", text: $enteredPassword)
            }
            .disableAutocorrection(true)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    //.fill(.clear)
                    .stroke(Color.secondary, style: StrokeStyle(lineWidth: 2))
            )
        .padding()
        }
        .padding(.horizontal)
    }
    
    var signUpButton: some View {
        Button {
            let user = UserModel(fullName: vm.fullName, userName: vm.userName, password: vm.password, email: vm.email)
            fullName = user.fullName
            userName = user.userName.lowercased()
            password = user.password
            email = user.email
            completeSignUp()
        } label: {
            Text("Sign up")
                .font(.headline.bold())
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.blue)
                .cornerRadius(10)
                .padding()
        }
        .padding(.horizontal)
    }
    
    var orDivider: some View {
        HStack {
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 0.5)
                .foregroundColor(Color.secondary)
            Text("OR")
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 0.5)
                .foregroundColor(Color.secondary)
        }
        .padding(.horizontal)
    }
    
    var loginMessage: some View {
//        NavigationLink {
//            LoginView()
//        } label: {
//            Text("Login")
//                .font(.headline.bold())
//                .foregroundColor(.white)
//                .padding()
//                .frame(maxWidth: .infinity)
//                .background(Color("LaunchAccentColor"))
//                .cornerRadius(10)
//                .padding()
//        }
//        .padding(.horizontal)
        
        HStack {
            Text("Already have an account?")
                .font(.subheadline.bold())
                //.foregroundColor(Color.theme.secondaryText)
            NavigationLink {
                Login()
            } label: {
                Text("Login")
                    .font(.subheadline.bold())
                    .foregroundColor(.blue)
            }
        }
        .padding()
    }
    
    func aunthenticateSignUp() -> Bool {
        if !enteredUserName.isEmpty && !enteredPassword.isEmpty && !enteredName.isEmpty && !enteredEmail.isEmpty && vm.isValidEmailAddr(strToValidate: enteredEmail) {
            return false
        } else {
            return true
        }
    }
    
    func completeSignUp() {
        vm.signUp(enteredUserName: enteredUserName, enteredPassword: enteredPassword, enteredEmail: enteredEmail, enteredFullName: enteredName)
    }
}

