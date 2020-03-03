//
//  SelectingLevelState.swift
//  Stress
//
//  Created by Shawn Koh on 22/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class SelectingLevelState: GKState, GameState {
    weak var stateMachine: GKStateMachine?
    weak var selectedLevelData: LevelData?

    func isValidNextState(_ stateClass: GKState.Type) -> Bool {
        stateClass is TitleScreenState.Type ||
            stateClass is PlayingState.Type ||
            stateClass is DesigningState.Type
    }

    func didEnter(from previousState: GKState?) {
        let gallery = GalleryViewController(store: gameStateMachine.stress.store, stateMachine: gameStateMachine)
        gameStateMachine.navigationController.pushViewController(gallery, animated: true)
    }

    func update(deltaTime seconds: TimeInterval) {}

    func willExit(to nextState: GKState) {
        switch nextState {
        case let playingState as PlayingState:
            playingState.levelData = selectedLevelData
        case let designingState as DesigningState:
            designingState.levelData = selectedLevelData
        default:
            ()
        }
        gameStateMachine.navigationController.popViewController(animated: false)
    }
}
