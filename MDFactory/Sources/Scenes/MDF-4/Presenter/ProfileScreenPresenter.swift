//
//  ProfileScreenPresenter.swift
//  MDFactory
//
//  Created by Andrei Maskal on 18/10/2022.
//

import Foundation

final class ProfileScreenPresenter {
    
    private weak var view: ProfilePresenterOutput?
    var achievements: [AchievementsModel]?

    init(view: ProfilePresenterOutput) {
        self.view = view
    }
}

extension ProfileScreenPresenter: ProfilePresenterInput {
    
    func getUserAchievements() {
        achievements = AchievementsModel.mocks
        view?.provaidUserAchievements(achievements)
    }
}
