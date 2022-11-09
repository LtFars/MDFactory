//
//  SettingPageUserModel.swift
//  MDFactory
//
//  Created by Dmitry Dorodniy on 26.10.2022.
//

import Foundation

struct User {
    var avatar: String?
    var name: String
    var surname: String
    var email: String
}

extension User {
    static var fetchData =
    User(avatar: "emoji",
         name: "Константин",
         surname: "Константинопольский",
         email: "mail.konstantin@mail.ru")
}

