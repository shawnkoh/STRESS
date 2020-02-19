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

    func isValidNextState(_ stateClass: GKState.Type) -> Bool {
        stateClass is TitleScreenState.Type
    }

    func didEnter(from previousState: GKState?) {
        // TEMP: Stub level
        let level = Level(name: "Stub", size: sceneStateMachine.presenter.frame.size)
        level.addPeg(Peg(center: CGPoint(x: 60, y: 300), type: .normal))
        level.addPeg(Peg(center: CGPoint(x: 120, y: 350), type: .objective))
        level.addPeg(Peg(center: CGPoint(x: 180, y: 400), type: .objective))
        level.addPeg(Peg(center: CGPoint(x: 240, y: 400), type: .objective))
        level.addPeg(Peg(center: CGPoint(x: 300, y: 350), type: .objective))
        level.addPeg(Peg(center: CGPoint(x: 360, y: 300), type: .objective))
        level.addPeg(Peg(center: CGPoint(x: 60, y: 500), type: .normal))
        level.addPeg(Peg(center: CGPoint(x: 120, y: 550), type: .objective))
        level.addPeg(Peg(center: CGPoint(x: 180, y: 600), type: .objective))
        level.addPeg(Peg(center: CGPoint(x: 240, y: 600), type: .objective))
        level.addPeg(Peg(center: CGPoint(x: 300, y: 550), type: .objective))
        level.addPeg(Peg(center: CGPoint(x: 360, y: 500), type: .objective))

        let gameScene = sceneStateMachine.gameScene
        gameScene.loadLevel(level)
        presenter.presentScene(gameScene)
    }

    func update(deltaTime seconds: TimeInterval) {

    }

    func willExit(to nextState: GKState) {

    }
}
