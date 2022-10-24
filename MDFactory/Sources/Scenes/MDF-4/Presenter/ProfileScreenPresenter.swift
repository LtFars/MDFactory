//
//  ProfileScreenPresenter.swift
//  MDFactory
//
//  Created by Andrei Maskal on 18/10/2022.
//

import Foundation

protocol ProfilePresenterInput: AnyObject {

    func getUserAchievements()
}

final class ProfileScreenPresenter {
    
    // MARK: - Elements
    
    private weak var view: ProfilePresenterOutput?
    private var achievements = [AchievementsModel]()

    // MARK: - Lifecycle
    
    init(view: ProfilePresenterOutput) {
        self.view = view
    }
}

    // MARK: - ProfilePresenterInput

extension ProfileScreenPresenter: ProfilePresenterInput {
    
    func getUserAchievements() {
        achievements = AchievementsModel.mocks
        view?.provaidUserAchievements(achievements)
    }
}
