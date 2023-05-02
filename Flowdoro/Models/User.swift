//
//  User.swift
//  Flexodoro
//
//  Created by Bruke on 5/1/23.
//

import Foundation

struct UserModel: Identifiable {
    let id = UUID()
    let fullName: String
    let userName: String
    let password: String
    let email: String
}
