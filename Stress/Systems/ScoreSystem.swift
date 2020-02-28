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
        var sum = 0
        var count = 0
        entities
            .compactMap { $0.component(ofType: ScoreComponent.self) }
            .filter { $0.shouldCount }
            .forEach {
                sum += $0.score
                count += 1
                $0.shouldCount = false
            }
        score += sum * count
    }
}
