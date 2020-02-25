//
//  ScoreSystem.swift
//  Stress
//
//  Created by Shawn Koh on 26/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class ScoreSystem: GKSystem {
    private(set) var score: Int = 0

    init(scene: GKScene) {
        super.init(scene: scene, componentClasses: [ScoreComponent.self])
    }

    override func update(deltaTime: TimeInterval) {
        entities
            .compactMap { $0.component(ofType: ScoreComponent.self) }
            .filter { $0.shouldCount }
            .forEach {
                score += $0.score
                $0.shouldCount = false
            }
    }
}
