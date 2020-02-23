//
//  PlayingState.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation
import CoreGraphics // TEMP

class PlayingState: GKState, SceneState {
    weak var stateMachine: GKStateMachine?
    var level: Level?

    func isValidNextState(_ stateClass: GKState.Type) -> Bool {
        stateClass is TitleScreenState.Type
    }

    func didEnter(from previousState: GKState?) {
        let playingScene = PlayingScene(stress: sceneStateMachine.stress)
        presenter.presentScene(playingScene)
    }

    func update(deltaTime seconds: TimeInterval) {}

    func willExit(to nextState: GKState) {}
}
