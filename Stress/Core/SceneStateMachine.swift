//
//  SceneStateMachine.swift
//  Stress
//
//  Created by Shawn Koh on 20/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class SceneStateMachine: GKStateMachine {
    unowned var stress: Stress
    unowned var presenter: GKView
    lazy var titleScreen = TitleScreen(stress: stress, size: presenter.frame.size)
    lazy var gameScene = GameScene(stress: stress, size: presenter.frame.size)
    lazy var levelDesignerScene = LevelDesignerScene(size: presenter.frame.size)

    init(stress: Stress, presenter: GKView, states: [GKState]) {
        self.stress = stress
        self.presenter = presenter
        super.init(states: states)
    }
}
