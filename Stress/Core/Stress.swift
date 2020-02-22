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
    private(set) var sceneStateMachine: SceneStateMachine!

    init(presenter: GKView) {
        sceneStateMachine = SceneStateMachine(stress: self,
                                              presenter: presenter,
                                              states: [TitleScreenState(),
                                                       DesigningState(),
                                                       PlayingState(),
                                                       SelectingLevelState()])
    }
}
