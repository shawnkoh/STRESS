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
    private(set) var stateMachine: GameStateMachine!
    let store = Store()

    init(presenter: GKView) {
        stateMachine = GameStateMachine(stress: self,
                                        presenter: presenter,
                                        states: [TitleScreenState(),
                                                 DesigningState(),
                                                 PlayingState(),
                                                 WinState(),
                                                 LoseState(),
                                                 PausedState(),
                                                 SelectingLevelState()])
    }
}
