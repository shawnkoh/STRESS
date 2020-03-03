//
//  Game.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

/// An object representing the entire state of the game `Stress`.
class Stress {
    private(set) var stateMachine: GameStateMachine!
    let store = Store()

    init(navigationController: UINavigationController) {
        stateMachine = GameStateMachine(stress: self,
                                        navigationController: navigationController,
                                        states: [TitleScreenState(),
                                                 DesigningState(),
                                                 PlayingState(),
                                                 WinState(),
                                                 LoseState(),
                                                 PausedState(),
                                                 SelectingLevelState()])
    }
}
