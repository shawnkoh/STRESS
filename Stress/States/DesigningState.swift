//
//  DesigningState.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class DesigningState: GKState, GameState {
    weak var stateMachine: GKStateMachine?
    var levelData: LevelData?

    func isValidNextState(_ stateClass: GKState.Type) -> Bool {
        stateClass is TitleScreenState.Type || stateClass is PlayingState.Type
    }

    func didEnter(from previousState: GKState?) {
        if levelData == nil {
            levelData = LevelData()
        }
        let backAction = {
            self.gameStateMachine.enter(TitleScreenState.self)
            return
        }
        let designingScene = DesigningScene(store: gameStateMachine.stress.store,
                                            levelData: levelData!,
                                            backAction: backAction)
        gameStateMachine.presenter.presentScene(designingScene)
    }

    func update(deltaTime seconds: TimeInterval) {}

    func willExit(to nextState: GKState) {}
}
