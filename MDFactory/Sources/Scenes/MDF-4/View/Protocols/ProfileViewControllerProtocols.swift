//
//  ProfileViewControllerProtocols.swift
//  MDFactory
//
//  Created by Andrei Maskal on 18/10/2022.
//

import Foundation

protocol ProfilePresenterInput: AnyObject {

    func getUserAchievements()
}

protocol ProfilePresenterOutput: AnyObject {
     
    func provaidUserAchievements(_ achievements: [AchievementsModel]?)
    
}
