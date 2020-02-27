//
//  PlayingState.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class PlayingState: GKState, SceneState {
    weak var stateMachine: GKStateMachine?
    var levelData: LevelData?

    func isValidNextState(_ stateClass: GKState.Type) -> Bool {
        stateClass is TitleScreenState.Type
    }

    func didEnter(from previousState: GKState?) {
        guard let levelData = levelData else {
            fatalError("Level has not been loaded.")
        }
        let playingScene = PlayingScene(stress: sceneStateMachine.stress, levelData: levelData)
        presenter.presentScene(playingScene)
    }

    func update(deltaTime seconds: TimeInterval) {}

    func willExit(to nextState: GKState) {}
}
