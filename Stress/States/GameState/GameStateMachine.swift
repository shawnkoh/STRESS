//
//  GameStateMachine.swift
//  Stress
//
//  Created by Shawn Koh on 26/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class GameStateMachine: GKStateMachine {
    unowned let playingScene: PlayingScene

    init(playingScene: PlayingScene, states: [GKState]) {
        self.playingScene = playingScene
        super.init(states: states)
    }
}
