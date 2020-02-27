//
//  SelectingLevelState.swift
//  Stress
//
//  Created by Shawn Koh on 22/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class SelectingLevelState: GKState, SceneState {
    weak var stateMachine: GKStateMachine?
    weak var selectedLevelData: LevelData?

    func isValidNextState(_ stateClass: GKState.Type) -> Bool {
        stateClass is TitleScreenState.Type ||
            stateClass is PlayingState.Type ||
            stateClass is DesigningState.Type
    }

    func didEnter(from previousState: GKState?) {
        let selectingScene = SelectingScene(stress: sceneStateMachine.stress)
        presenter.presentScene(selectingScene)
    }

    func update(deltaTime seconds: TimeInterval) {

    }

    func willExit(to nextState: GKState) {
        if let playingState = nextState as? PlayingState {
            playingState.levelData = selectedLevelData
        } else if let designingState = nextState as? DesigningState {
            designingState.levelData = selectedLevelData
        }
    }
}
