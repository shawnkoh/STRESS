//
//  Game.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import CoreGraphics

/// An object representing the entire state of the game `Stress`.
class Stress {
    var size: CGSize
    lazy var gameScene = GameScene(size: size)
    lazy var levelDesignerScene = LevelDesignerScene(size: size)

    let stateMachine = GKStateMachine(states: [TitleScreenState(), DesigningState(), PlayingState()])

    init(size: CGSize) {
        self.size = size
    }
}
