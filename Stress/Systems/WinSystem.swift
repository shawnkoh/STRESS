//
//  WinSystem.swift
//  Stress
//
//  Created by Shawn Koh on 26/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class WinSystem: GKSystem {
    init(scene: GKScene) {
        super.init(scene: scene, requiredComponents: [ObjectiveComponent.self])
    }

    override func update(deltaTime: TimeInterval) {
        guard let levelScene = scene as? LevelPlayingScene else {
            fatalError("ObjectiveSystem has been attached to an incorrect scene")
        }
        if entities.isEmpty {
            levelScene.parent.stateMachine.enter(WinState.self)
        }
    }
}
