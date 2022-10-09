//
//  AchievementsModel.swift
//  MDFactory
//
//  Created by Andrei Maskal on 25/09/2022.
//


import Foundation

struct AchievementsModel: Identifiable, Hashable  {
    var id = UUID()
    let name: String
    let icon: String
    
    static var mocks: [AchievementsModel] = [AchievementsModel(name: "Плейлисты",
                                               icon: "horse"),
                                             AchievementsModel(name: "Артисты",
                                              icon: "emoji"),
                                             AchievementsModel(name: "Альбомы",
                                              icon: "horse"),
                                             AchievementsModel(name: "Песни",
                                              icon: "emoji"),
                                             AchievementsModel(name: "Телешоу",
                                              icon: "horse"),
                                             AchievementsModel(name: "Видеоклипы",
                                              icon: "emoji"),
                                             AchievementsModel(name: "Жанры",
                                              icon: "emoji"),
                                             AchievementsModel(name: "Сборники",
                                              icon: "horse"),
                                             AchievementsModel(name: "Авторы",
                                              icon: "emoji")
                                        ]
}
