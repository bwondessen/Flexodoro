//
//  HomeViewModel.swift
//  Flowdoro
//
//  Created by Bruke on 10/24/22.
//

import SwiftUI
import Combine
import UserNotifications
import LocalAuthentication
//import Firebase

class HomeViewModel: ObservableObject {
    @Published var user: UserModel? = nil
    
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var timerPaused: Bool = true
    
    @Published var focusTime: Double = 1500
    @Published var focusTimeRemaining: Double = 1500
    @Published var flowTime: Double = 300
    @Published var flowTimeRemaining: Double = 300
    @Published var breakTime: Double = 300
    @Published var breakTimeRemaining: Double = 300
    @Published var totalCycles: Int = 0
    
    @Published var inFocus: Bool = true
    @Published var inFlow: Bool = false
    @Published var inBreak: Bool = false
    
    @Published var focusSelected: Bool = false
    @Published var flowSelected: Bool = false
    @Published var breakSelected: Bool = false
    
    @Published var counter: Int = 0
    
    @AppStorage("isUnlocked") var isUnlocked: Bool = false
    @AppStorage("isSignedUp") var isSignedUp: Bool = false
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("userName") var userName: String = ""
    @AppStorage("password") var password: String = ""
    
    @AppStorage("fullName") var fullName: String = ""
    @AppStorage("email") var email: String = ""
    
    @AppStorage("faceIDEnabled") var faceIDEnabled: Bool = false
    @AppStorage("passcodeRequired") var passcodeRequired: Bool = false
        
//    @Published var totalTimeStudied: Double = 0
        
//    var totalTimeStudied: Double {
//        (focusTime - focusTimeRemaining) + (flowTime - flowTimeRemaining)
//    }
    
    // Timer
    func startTimer() {
        timerPaused = false
        self.timer  = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    func pauseTimer() {
        timerPaused = true
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        self.timer.upstream.connect().cancel()
    }
    
    func restartTimer() {
        pauseTimer()
        if !inFocus {
            focusTimeRemaining = focusTime
        }
        flowTimeRemaining = flowTime
        breakTimeRemaining = breakTime
        counter = 0
    }
    
    func end() {
        if inBreak && breakTimeRemaining > 0 {
            totalCycles += 1
        }
        pauseTimer()
        inFocus = true
        inFlow = false
        inBreak = false
//        totalTimeStudied += (focusTime - focusTimeRemaining) + (flowTime - flowTimeRemaining)
        focusTimeRemaining = focusTime
        flowTimeRemaining = flowTime
        breakTimeRemaining = breakTime
        counter = 0
    }
    
    func skip() {
        counter = 0
        if focusTime > focusTimeRemaining {
            pauseTimer()
            //restartTimer()
            if inFocus {
                inFocus = false
                inFlow = true
                inBreak = false
            } else if inFlow {
                inFocus = false
                inFlow = false
                inBreak = true
            } else if inBreak {
                end()
            }
        }
    }
    
    func timeRemainingInPercent() -> Double {
        guard
            focusTimeRemaining >= 0,
            flowTimeRemaining >= 0
        else { return 0 }
        
        if inFocus {
            return Double(counter) / focusTime
        } else if inFlow {
            return Double(counter) / flowTime
        } else {
            return Double(counter) / breakTime
        }
    }
    
    func incrementCounter() -> Int {
        if counter <= Int(focusTime) - 1 {
            counter += 1
        }
        return counter
    }
    
    // Authenticaiton
//    func authenticate() {
//        let context = LAContext()
//        var error: NSError?
//
//        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
//            let reason = "Please authenticate yourself to use Brypto."
//
//            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
//                if success {
//                    Task { @MainActor in
//                        self.isUnlocked = true
//                    }
//                } else {
//                    // error
//                }
//            }
//        } else {
//            // no biometrics
//        }
//    }
    
//    func signUp(enteredUserName: String, enteredPassword: String, enteredEmail: String, enteredFullName: String) {
//        if !enteredUserName.isEmpty && !enteredPassword.isEmpty && !enteredEmail.isEmpty && !enteredFullName.isEmpty {
//            self.isUnlocked = true
//            self.isSignedUp = true
//            self.isLoggedIn = true
//        }
//    }
    
//    func signUp(enteredUserName: String, enteredPassword: String, enteredEmail: String, enteredFullName: String) {
//        Auth.auth().createUser(withEmail: enteredEmail, password: enteredPassword) { result, error in
//            if error != nil {
//                print(error?.localizedDescription ?? "error")
//            }
//        }
//
//        if !enteredUserName.isEmpty && !enteredPassword.isEmpty && !enteredEmail.isEmpty && isValidEmailAddr(strToValidate: enteredEmail) && !enteredFullName.isEmpty {
//            self.isUnlocked = true
//            self.isSignedUp = true
//            self.isLoggedIn = true
//
//            user = UserModel(fullName: enteredFullName, userName: enteredUserName, password: enteredPassword, email: enteredPassword)
//        }
//    }
//
//    func isValidEmailAddr(strToValidate: String) -> Bool {
//      let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"  // 1
//
//      let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)  // 2
//
//      return emailValidationPredicate.evaluate(with: strToValidate)  // 3
//    }
//
//    func signIn(userName: String, password: String) {
//        if userName == user?.userName && password == user?.password {
//            self.isUnlocked = true
//            self.isSignedUp = true
//        }
//    }
//
//    func login(enteredUserName: String, enteredPassword: String) {
//        if enteredUserName.lowercased() == user?.userName.lowercased() && enteredPassword == user?.password {
//            self.isUnlocked = true
//            self.isLoggedIn = true
//        }
//    }
//
//    func enableFaceID(faceIDEnabled: Bool) {
//        if faceIDEnabled {
//            authenticate()
//        }
//    }
//
//    func logOut() {
//        self.isLoggedIn = false
//        self.isUnlocked = false
//
//        do {
//            try Auth.auth().signOut()
//        } catch {
//
//        }
//    }
//
//    func deleteAccount() {
//        self.isLoggedIn = false
//        self.isUnlocked = false
//        self.isSignedUp = false
//
//        user = nil
//    }
}
