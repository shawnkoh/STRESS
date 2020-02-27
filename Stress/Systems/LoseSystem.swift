//
//  LoseSystem.swift
//  Stress
//
//  Created by Shawn Koh on 28/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class LoseSystem: GKSystem {
    init(scene: GKScene) {
        super.init(scene: scene, componentClasses: [ObjectiveComponent.self])
    }

    override func update(deltaTime: TimeInterval) {
        guard let levelScene = scene as? LevelPlayingScene else {
            fatalError("ObjectiveSystem has been attached to an incorrect scene")
        }
        guard !entities.isEmpty && levelScene.entities(ofType: Ball.self).isEmpty else {
            return
        }

        let hasAmmo = levelScene.entities(ofType: Cannon.self).contains {
            $0.component(ofType: AmmoComponent.self)?.ammo ?? 0 > 0
        }

        if !hasAmmo {
            levelScene.parent.stateMachine.enter(LoseState.self)
        }
    }
}
